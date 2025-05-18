# 🛡️ Suricata Setup Script for Malicious Traffic 

This script automates the installation and configuration of **Suricata** as an IDS to monitor traffic between lab VMs. It prepares Suricata to detect threats using **Emerging Threats open-source rules**.

---

## ✅ What This Script Does

- Installs Suricata and required tools
- Creates a Suricata rules directory at `/etc/suricata/rules`
- Downloads and extracts the **Emerging Threats ruleset**
- Activates all `alert` rules for detection
- Updates `suricata.yaml` to:
  - Set default rule path
  - Add all valid rule files
  - Enable traffic capture on interface `eth1`
- Enables Suricata as a system service
- Test the configuration to confirm it's valid

---

## ⚙️ Lab Interface Setup

- Suricata **monitors `eth0` by default**, so it is not explicitly added in the script
- This script adds monitoring on `eth1`, which should be connected to the VM network (e.g., between attacker and victim machines)
- This is preconfigured if you followed the [Lab Network Guide](../README.md#phase-1-vm-infrastructure-setup)

---

## 📦 Script File

- `suricata_lab_setup.sh` — One-click setup of Suricata for lab monitoring

---

## 🚀 Usage

From your Kali VM:

```bash
cd suricata_setup
sudo ./suricata_lab_setup.sh
