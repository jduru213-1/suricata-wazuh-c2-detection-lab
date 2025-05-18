#!/bin/bash

set -e

OSSEC_CONF="/var/ossec/etc/ossec.conf"
SURICATA_LOG="/var/log/suricata/eve.json"

echo "[+] Backing up ossec.conf..."
sudo cp "$OSSEC_CONF" "$OSSEC_CONF.bak"

echo "[+] Checking if Suricata eve.json log is already configured..."
if grep -q "$SURICATA_LOG" "$OSSEC_CONF"; then
    echo "[!] Suricata log is already present in ossec.conf."
    exit 0
fi

echo "[+] Adding Suricata eve.json logs to Wazuh Agent config..."

sudo sed -i "/<\/ossec-config>/i \\
<localfile>\\
    <log_format>json</log_format>\\
    <location>${SURICATA_LOG}</location>\\
</localfile>" "$OSSEC_CONF"

echo "[+] Restarting Wazuh Agent..."
sudo systemctl restart wazuh-agent

echo "[+] Done! Suricata eve.json log added to ossec.conf."
