# Suricata-Wazuh C2 Detection Lab 🚨

[![MIT License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)  
[![GitHub issues](https://img.shields.io/github/issues/jduru213-1/suricata-wazuh-c2-detection-lab)](https://github.com/jduru213-1/suricata-wazuh-c2-detection-lab/issues)  
[![GitHub stars](https://img.shields.io/github/stars/jduru213-1/suricata-wazuh-c2-detection-lab)](https://github.com/jduru213-1/suricata-wazuh-c2-detection-lab/stargazers)  
---

## 📖 Overview

This repository contains automation scripts to help build a lab environment for simulating a phishing attack that delivers malicious C2 server traffic via Google Calendar, with detection and response powered by Wazuh and Suricata.

- Note: Assistance was provided by OpenAI's ChatGPT to develop automation scripts designed to help others follow along with the project and avoid manually typing commands line by line.
---

## ⚙️ Phase 1: VM Infrastructure Setup (Prerequisites)

Before running the scripts here, please ensure your lab VM infrastructure is ready. For detailed instructions on VM setup and configuration, please check the associated blog post:

[**Lab Infrastructure Setup Blog (Coming Soon)**](#)  

---

## 🛠️ Included Scripts and Setup Order

- sp = setup
  
| Step | Script                                          | Description                                                                                          |
|------|------------------------------------------------|----------------------------------------------------------------------------------------------------|
| 1    | [`kali_gateway_sp`](kali_gateway_sp/)           | Configures Kali Linux as a NAT gateway to route and inspect lab traffic                            |
| 2    | [`suricata_sp`](suricata_sp/)                   | Installs and configures Suricata IDS with Emerging Threats rules                                   |
| 3    | [`wazuh-agent-suricata_sp`](wazuh-agent-suricata_sp/) | Installs and configures the Wazuh agent to collect and forward Suricata logs                       |
| 4    | [`response_scripts`](response_scripts/)         | Contains scripts to block/unblock malicious traffic and isolate Windows hosts during incident response |


---

## 🏃‍♂️ How to Use

**Note:** Use these scripts as referenced in the setup guide.

Clone the repository:

```bash
git clone https://github.com/jduru213-1/suricata-wazuh-c2-detection-lab.git
cd suricata-wazuh-c2-detection-lab

