# 🔁  Kali VM NAT & IP Forwarding Script
This script configures your Kali Linux machine as a network router for the suricata-wazuh-c2-detection lab. It enables internet access for your internal VMs by routing their traffic through Kali, which will later allow Suricata to monitor and analyze that traffic effectively.

---

## 🛠️ What the Script Does

- Enables **IP forwarding** for packet routing
- Configures **NAT (masquerading)** on `eth2` (internet-facing interface)
- Allows traffic forwarding:
  - From `vmnet1` (Windows 10 Machine (Hacker)) → `eth2`
  - From `vmnet2` (Windows Server 2022 (Victim) or Kali VM) → `eth2`
- Saves **iptables rules** to persist after reboot

---

## ⚙️ Interface Configuration (Predefined)

- `eth2` — Internet-facing interface (NAT or bridged)
- `vmnet1` — Connected to the Windows 10 Machine (Hacker)
- `vmnet2` — Connected to the Windows Server 2022 (Victim) or Kali VM

These interfaces are **predefined for this lab**. No modifications are necessary if you followed the [Phase 1: Lab Infrastructure Guide](../README.md#phase-1-vm-infrastructure-setup).

---

## 📂 Script File

- `setup_kali_gateway.sh` — Turns Kali into a NAT gateway for routing VM traffic

---

## 🚀 Usage
From your Kali VM

```bash
cd kali_gateway_setup
sudo ./setup_kali_gateway.sh
