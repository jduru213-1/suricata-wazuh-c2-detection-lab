#!/bin/bash

set -e

echo "[+] Installing Suricata..."
sudo apt update && sudo apt install -y suricata wget

echo "[+] Creating rules directory..."
if [ ! -d /etc/suricata/rules ]; then
    sudo mkdir -p /etc/suricata/rules
fi
cd /etc/suricata/rules

echo "[+] Downloading Emerging Threats Open-Source Rules..."
sudo wget https://rules.emergingthreats.net/open/suricata-6.0/emerging.rules.tar.gz

echo "[+] Extracting rules..."
sudo tar -xzvf emerging.rules.tar.gz
sudo rm emerging.rules.tar.gz

echo "[+] Creating custom rule to detect ICMP ping traffic..."
echo 'alert icmp any any -> any any (msg:"ICMP Ping Detected"; sid:1000001; rev:1; classtype:icmp-event; metadata:attack_target Host, protocol ICMP;)' | sudo tee /etc/suricata/rules/icmp-ping.rules

echo "[+] Uncommenting all 'alert' rules..."
sudo find . -type f -name "*.rules" -exec sed -i 's/^#\s*alert/alert/' {} \;
echo "[+] Setting default-rule-path to /etc/suricata/rules in suricata.yaml..."

echo "[+] Setting default-rule-path to /etc/suricata/rules in suricata.yaml..."
sudo sed -i 's|^default-rule-path:.*|default-rule-path: /etc/suricata/rules|' /etc/suricata/suricata.yaml

echo "[+] Preparing list of rule files..."
rules_list=$(ls /etc/suricata/rules/*.rules | sed 's|.*/||' | grep -Ev 'dnp3-events.rules|modbus-events.rules|app-layer-events.rules|files.rules|decoder-events.rules' | sed 's/^/  - /')

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

