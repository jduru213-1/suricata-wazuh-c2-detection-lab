# 🔗 Suricata to Wazuh Integration Script

This setup script (`suricata_to_wazuh.sh`) automatically configures the Wazuh agent to ingest Suricata’s JSON-based `eve.json` log file for security event monitoring and detection.

---

## 💡 What It Does

- Backs up the existing `ossec.conf` file
- Checks if Suricata's `eve.json` is already configured
- Adds a new `<localfile>` entry pointing to `/var/log/suricata/eve.json`
- Restarts the Wazuh agent to apply changes
- Helps Wazuh start parsing Suricata alerts for real-time detection and correlation

---

## ⚙️ Requirements

- Wazuh agent installed and running
- Suricata logs enabled at: `/var/log/suricata/eve.json`
- Root or sudo privileges

---

## 📁 File

- `suricata_to_wazuh.sh` — Bash script that adds Suricata log monitoring to the Wazuh agent configuration.

---

## 🚀 Usage

```bash
chmod +x suricata_to_wazuh.sh
sudo ./suricata_to_wazuh.sh
