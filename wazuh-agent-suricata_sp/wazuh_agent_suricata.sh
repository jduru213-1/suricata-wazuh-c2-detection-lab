#!/bin/bash
set -e

# Prompt for Wazuh Manager IP or hostname
while true; do
  read -rp "Enter your Wazuh Manager IP or hostname: " WAZUH_MANAGER
  if [[ -z "$WAZUH_MANAGER" ]]; then
    echo "Wazuh Manager IP/hostname cannot be empty. Please try again."
  else
    break
  fi
done

OSSEC_CONF="/var/ossec/etc/ossec.conf"
SURICATA_LOG="/var/log/suricata/eve.json"

echo "[+] Adding Wazuh repository and GPG key..."
curl -s https://packages.wazuh.com/key/GPG-KEY-WAZUH | \
  gpg --no-default-keyring --keyring gnupg-ring:/usr/share/keyrings/wazuh.gpg --import && \
  chmod 644 /usr/share/keyrings/wazuh.gpg

echo "deb [signed-by=/usr/share/keyrings/wazuh.gpg] https://packages.wazuh.com/4.x/apt/ stable main" | \
  sudo tee /etc/apt/sources.list.d/wazuh.list

echo "[+] Updating package information..."
sudo apt-get update

echo "[+] Installing Wazuh Agent with WAZUH_MANAGER=$WAZUH_MANAGER ..."
sudo WAZUH_MANAGER="$WAZUH_MANAGER" apt-get install -y wazuh-agent

echo "[+] Backing up ossec.conf..."
sudo cp "$OSSEC_CONF" "$OSSEC_CONF.bak"

echo "[+] Updating <address> in ossec.conf to $WAZUH_MANAGER ..."
sudo sed -i "s|<address>.*</address>|<address>$WAZUH_MANAGER</address>|" "$OSSEC_CONF"

echo "[+] Checking if Suricata eve.json log is already configured..."

echo "[+] Checking if Suricata eve.json log is already configured..."
if sudo grep -q "$SURICATA_LOG" "$OSSEC_CONF"; then
    echo "[!] Suricata log is already present in ossec.conf."
else
    echo "[+] Adding Suricata eve.json logs to Wazuh Agent config..."
    sudo sed -i '/<location>\/var\/log\/dpkg.log<\/location>/{
      N
      s|</localfile>|</localfile>\n\n  <localfile>\n    <log_format>json</log_format>\n    <location>/var/log/suricata/eve.json</location>\n  </localfile>|
    }' "$OSSEC_CONF"
fi

echo "[+] Enabling and restarting Wazuh Agent..."
sudo systemctl daemon-reexec
sudo systemctl enable wazuh-agent
sudo systemctl restart wazuh-agent

echo "[+] Done! Wazuh Agent installed and Suricata log configured."
sudo systemctl status wazuh-agent --no-pager
