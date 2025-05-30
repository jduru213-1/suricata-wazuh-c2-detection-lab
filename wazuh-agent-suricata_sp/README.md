# 🔗 Suricata to Wazuh Integration Script

This setup script (`wazuh-agent-suricata.sh`) automates the installation and configuration of the Wazuh agent to ingest Suricata’s JSON alerts.

---

## 💡 What It Does

- Adds the Wazuh repository and GPG key
- Installs the Wazuh agent with user-provided Wazuh Manager IP/hostname
- Backs up the existing `ossec.conf` file
- Checks if Suricata's `eve.json` log is already configured
- Adds a new `<localfile>` entry pointing as `/var/log/suricata/eve.json` in the `ossec.conf` file
- Enables and restarts the Wazuh agent service to apply changes
- Helps Wazuh start parsing Suricata alerts for real-time detection and correlation

---

## ⚙️ Requirements

- Root or sudo privileges
- Internet access to add Wazuh repository and download packages
- Suricata logs enabled at: `/var/log/suricata/eve.json`

---

## 📁 Files

- `wazuh-agent-suricata.sh` — Bash script that installs and configures the Wazuh agent for Suricata log monitoring  
- References:  
  - [Wazuh Agent Installation Guide for Linux](https://documentation.wazuh.com/current/installation-guide/wazuh-agent/wazuh-agent-package-linux.html)  
  - [Integrate Network IDS Suricata with Wazuh](https://documentation.wazuh.com/current/proof-of-concept-guide/integrate-network-ids-suricata.html)  

---

## 🚀 Usage

```bash
cd wazuh-agent-suricata_sp
chmod +x wazuh-agent-suricata.sh
sudo ./wazuh-agent-suricata.sh

