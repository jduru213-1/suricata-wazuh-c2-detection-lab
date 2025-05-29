#!/bin/bash

echo "                                                              "
echo "--------------------------------------------------------------"
echo "                 Suricata Lab Setup/Installation              "
echo "--------------------------------------------------------------" 
echo "                                                              " 

set -e

echo "[+] Installing Suricata..."
sudo apt update && sudo apt install -y suricata wget

echo "[+] Creating rules directory..."
if [ ! -d /etc/suricata/rules ]; then
    sudo mkdir -p /etc/suricata/rules
fi

echo "[+] Creating local rules directory..."
if [ ! -d /etc/suricata/rules/local ]; then
    sudo mkdir -p /etc/suricata/rules/local
fi

cd /etc/suricata/rules

echo "[+] Downloading Emerging Threats Open-Source Rules..."
sudo wget -q https://rules.emergingthreats.net/open/suricata-6.0/emerging.rules.tar.gz

echo "[+] Extracting rules..."
sudo tar -xzvf emerging.rules.tar.gz --strip-components=1
sudo rm emerging.rules.tar.gz

echo "[+] Extracting 'Suricata: Alert - ET INFO Python SimpleHTTP ServerBanner' rule from emerging-info.rules..."
sudo grep 'Suricata: Alert - ET INFO Python SimpleHTTP ServerBanner' emerging-info.rules -A 1 | sudo tee /etc/suricata/rules/local/python-simplehttp.rules >/dev/null

echo "[+] Creating local custom rules with comments..."

# ICMP ping rule
sudo tee /etc/suricata/rules/local/icmp-ping.rules >/dev/null <<EOF
# Detects potential ICMP Echo Request (ping) traffic (IPv4)
alert icmp any any -> any any (msg:"Potential ICMP Echo Request (IPv4)"; itype:8; sid:1000002; rev:1;)
EOF

# Suspicious C2 HTTP executable download rule 
sudo tee /etc/suricata/rules/local/c2-traffic.rules >/dev/null <<EOF
# Detects potential C2 traffic - executable download via HTTP GET request
alert http any any -> any any (msg:"Potential C2 Traffic - Executable Download via HTTP"; flow:to_server,established; content:"GET"; http_method;  sid:2000110; rev:3;)
EOF

echo "[+] Setting default-rule-path to /etc/suricata/rules/local in suricata.yaml..."
sudo sed -i 's|^default-rule-path:.*|default-rule-path: /etc/suricata/rules/local|' /etc/suricata/suricata.yaml

echo "[+] Preparing list of rule files from local folder only..."
rules_list=$(ls /etc/suricata/rules/local/*.rules 2>/dev/null | sed 's|.*/||' | sed 's/^/  - /')

echo "[+] Updating suricata.yaml rule-files section..."
sudo sed -i '/^rule-files:/,/^[^[:space:]]/d' /etc/suricata/suricata.yaml
echo "rule-files:" | sudo tee -a /etc/suricata/suricata.yaml
echo "$rules_list" | sudo tee -a /etc/suricata/suricata.yaml

echo "[+] Adding AF_PACKET interface eth1..."
sudo sed -i '/^af-packet:/a\  - interface: eth1' /etc/suricata/suricata.yaml


echo "[+] Enabling and restarting Suricata..."
sudo systemctl enable suricata
sudo systemctl restart suricata

echo "[+] Testing Suricata configuration..."
sudo suricata -T -c /etc/suricata/suricata.yaml -v

echo "[+] Suricata setup complete and monitoring interfaces eth0 & eth1!"
