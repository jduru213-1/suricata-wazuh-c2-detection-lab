#!/bin/bash

echo "                                                         "
echo "---------------------------------------------------------"
echo "             Suricata Lab Setup/Installation             "
echo "---------------------------------------------------------"
echo "                                                         " 

set -e

echo "[+] Installing Suricata..."
sudo apt update && sudo apt install -y suricata wget

echo "[+] Creating rules directory..."
sudo mkdir -p /etc/suricata/rules/local

cd /etc/suricata/rules

echo "[+] Downloading Emerging Threats Open-Source Rules..."
sudo wget https://rules.emergingthreats.net/open/suricata-6.0/emerging.rules.tar.gz

echo "[+] Extracting rules..."
sudo tar -xzvf emerging.rules.tar.gz -C /etc/suricata/rules --strip-components=1
sudo rm emerging.rules.tar.gz

echo "[+] Creating custom ICMP ping rule..."
echo 'alert icmp any any -> any any (msg:"Potential ICMP Echo Request (IPv4)"; itype:8; sid:1000002; rev:1; threshold:type limit, track by_rule, count 1, seconds 60;)' | sudo tee /etc/suricata/rules/local/icmp-ping.rules

echo "[+] Adding  Python SimpleHTTPServer detection rule from ET..."
echo 'alert http $HOME_NET any -> any any (msg:"ET INFO Python SimpleHTTP ServerBanner"; flow:established; http.server; content:"SimpleHTTP/"; startswith; content:"Python/"; distance:0; reference:url,wiki.python.org/moin/BaseHttpServer; classtype:misc-activity; sid:2034636; rev:2; metadata:affected_product Windows_XP_Vista_7_8_10_Server_32_64_Bit, attack_target Client_Endpoint, created_at 2021_12_08, deployment Perimeter, confidence High, signature_severity Minor, updated_at 2021_12_08; threshold:type limit, track by_rule, count 1, seconds 60;)' | sudo tee /etc/suricata/rules/local/python-http.rules

echo "[+] Setting default-rule-path to /etc/suricata/rules/local in suricata.yaml..."
sudo sed -i 's|^default-rule-path:.*|default-rule-path: /etc/suricata/rules/local|' /etc/suricata/suricata.yaml

echo "[+] Preparing list of local rule files..."
rules_list=$(ls /etc/suricata/rules/local/*.rules | sed 's|.*/||' | sed 's/^/  - /')

echo "[+] Updating suricata.yaml rule-files section..."
sudo sed -i '/^rule-files:/,/^[^[:space:]]/d' /etc/suricata/suricata.yaml
echo "rule-files:" | sudo tee -a /etc/suricata/suricata.yaml
echo "$rules_list" | sudo tee -a /etc/suricata/suricata.yaml

echo "[+] Adding AF_PACKET interface eth1..."
sudo sed -i '/^af-packet:/a\  - interface: eth1' /etc/suricata/suricata.yaml

echo "[+] Enabling and restarting Suricata..."
sudo systemctl enable suricata
sudo systemctl restart suricata

echo "[+] Testing configuration..."
sudo suricata -T -c /etc/suricata/suricata.yaml -v

echo "[+] Suricata setup complete and monitoring eth0 & eth1!"
