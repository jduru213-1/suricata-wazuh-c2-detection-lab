# Suricata-Wazuh C2 Detection Lab 🚨🔍

[![MIT License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)  
[![GitHub issues](https://img.shields.io/github/issues/jduru213-1/suricata-wazuh-c2-detection-lab)](https://github.com/jduru213-1/suricata-wazuh-c2-detection-lab/issues)  
[![GitHub stars](https://img.shields.io/github/stars/jduru213-1/suricata-wazuh-c2-detection-lab)](https://github.com/jduru213-1/suricata-wazuh-c2-detection-lab/stargazers)  

---

## 📖 Overview

This repository contains automation scripts to help set up and configure components for detecting malicious C2 server traffic in phishing attack simulations using Google Calendar phishing and Wazuh for monitoring.

---

## 📂 Included Scripts

| File                       | Description                                            |
| -------------------------- | ------------------------------------------------------|
| `suricata_lab_setup.sh`    | Bash script to install and configure Suricata with Emerging Threats rules |
| `setup_kali_gateway.sh`    | Bash script to configure Kali Linux as a gateway for lab network traffic routing |

---

## 🛠️ Usage

### Prerequisites

- Ubuntu or Debian-based Linux system  
- sudo privileges  

### Setup

Clone the repo and run the setup scripts as needed:

```bash
git clone https://github.com/jduru213-1/suricata-wazuh-c2-detection-lab.git
cd suricata-wazuh-c2-detection-lab

# Run Suricata setup
sudo bash suricata_lab_setup.sh

# (Optional) Run Kali gateway setup
sudo bash setup_kali_gateway.sh
