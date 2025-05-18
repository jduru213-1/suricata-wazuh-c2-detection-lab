# Suricata-Wazuh C2 Detection Lab 🚨

[![MIT License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)  
[![GitHub issues](https://img.shields.io/github/issues/jduru213-1/suricata-wazuh-c2-detection-lab)](https://github.com/jduru213-1/suricata-wazuh-c2-detection-lab/issues)  
[![GitHub stars](https://img.shields.io/github/stars/jduru213-1/suricata-wazuh-c2-detection-lab)](https://github.com/jduru213-1/suricata-wazuh-c2-detection-lab/stargazers)  

---

## 📖 Overview

This repository contains automation scripts for setting up a lab environment to detect malicious C2 server traffic in phishing attack simulations, using Google Calendar phishing, Wazuh, and Suricata.

---

## ⚙️ Phase 1: VM Infrastructure Setup (Prerequisites)

Before running the scripts here, ensure your lab VM infrastructure is ready. For detailed instructions on VM setup and configuration, please check the associated blog post:

[**Lab Infrastructure Setup Blog (Coming Soon)**](#)  

---

## 🛠️ Included Scripts and Setup Order

| Step | Script                     | Description                                               |
|-------|----------------------------|-----------------------------------------------------------|
| 1     | `setup_kali_gateway.sh`    | Configures Kali Linux as a gateway for lab network routing |
| 2     | `suricata_lab_setup.sh`    | Installs and configures Suricata IDS with Emerging Threats rules |

---

## 🏃‍♂️ How to Use

**Note:** Use these scripts as referenced in the setup guide.

Clone the repository:

```bash
git clone https://github.com/jduru213-1/suricata-wazuh-c2-detection-lab.git
cd suricata-wazuh-c2-detection-lab

