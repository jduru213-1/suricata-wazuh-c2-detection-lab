# 🔐 Block, Unblock & Host Isolation Scripts for Lab Traffic Control

These scripts were created (except for `isolate_host.cmd`) for our lab environment to manually isolate malicious traffic between virtual machines. This was necessary due to issues automating the response using **Wazuh Active Responses**. They provide a quick and flexible way to block, unblock, or isolate hosts during investigations.

---

## 🛠 What the Scripts Do

### `block_ip.sh`
- Blocks all or specific **TCP traffic** between two IP addresses.
- Supports **port-specific blocking** (e.g., block traffic to port `4444` often used in reverse shells or C2).
- Can be used to simulate **host isolation** or **malicious traffic containment** in a controlled lab setting.
-  **Executed on the Kali Linux machine** that acts as the **router/firewall** between the attacker and victim VMs.


### `unblock_ip.sh`
- Reverses the effect of `block_ip.sh` by removing specific iptables rules.
- Supports **unblocking a specific port** or all traffic between two IPs.
- Useful for restoring lab connectivity after threat validation or recovery.
- 🖥️**Also executed on the Kali router** to restore previously blocked connections.

### `isolate_host.cmd`
- Windows `.cmd` script used to **immediately isolate a Windows host** from the network.
- First step in an automated response triggered by a Wazuh alert (e.g., detecting suspicious `certutil` usage linked to C2 activity).
- Applies Windows Firewall rules to block **all inbound and outbound traffic** on the machine.

---

## ⚙ Example Use Case 

You detect the use of `certutil` downloading a malicious payload (e.g., `mimikatz.exe`) from a C2 server:

- **Attacker IP**: `192.168.247.15`  
- **Victim IP**: `192.168.153.10`  
- **Port**: `4444`

Use `block_ip.sh` to instantly **cut off traffic** between the attacker and victim on that port.

If the alert is confirmed as a threat, execute `isolate_host.cmd` on the victim Windows host to fully **disconnect it from the network** for containment and analysis. Once the investigation is complete, use `unblock_ip.sh` to **restore connectivity**.

This entire flow was implemented in our `suricata-wazuh-c2-detection-lab` environment.

---

## 📂 Script Files

- `block_ip.sh` — Blocks traffic between attacker and victim by IP and optional port.
- `unblock_ip.sh` — Unblocks the previously blocked traffic rules.
- `isolate_host.cmd` — Windows host isolation via firewall rule enforcement.

---

## 🚀 Usage

### 🔒 Blocking Traffic on Kali
```bash
cd suricata-wazuh-c2-detection-lab/response_scripts
sudo ./block_ip.sh
