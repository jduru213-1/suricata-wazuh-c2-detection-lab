# 🔐 Block & Unblock Scripts for Lab Traffic Isolation

These scripts were created for our lab enviroment to manually isolate malicious traffic between virtual machines. This was necessary due to issues automating the response using **Wazuh Active Responses**. They provide a quick and flexible way to **block or unblock traffic between attacker and victim machines** during testing and incident simulation.

---

## 🛠️ What the Scripts Do

### `block.sh`
- Blocks all or specific **TCP traffic** between two IP addresses.
- Supports **port-specific blocking** (e.g., block traffic to port `4444` often used in reverse shells or C2).
- Can be used to simulate **host isolation** or **malicious traffic containment** in a controlled lab setting.

### `unblock.sh`
- Reverses the effect of `block.sh` by removing specific iptables rules.
- Supports **unblocking a specific port** or all traffic between two IPs.
- Useful for restoring lab connectivity after threat validation or recovery.

---

## ⚙️ Example Use Case 

You detect the use of `certutil` downloading a malicious payload (e.g., `mimikatz.exe`) from a C2 server:

- **Attacker IP**: `192.168.247.15`  
- **Victim IP**: `192.168.153.10`  
- **Port**: `4444`

Use the `block_ip.sh` script to instantly **cut off traffic** between the attacker and victim on that port. Once the lab investigation is complete, use `unblock_ip.sh` to **restore connectivity**.

- This use case was the one we simulated and repsosnded to for our **suricata-wazuh-c2-detection-lab**.  
---

## 📂 Script Files

- `block_ip.sh` — Blocks traffic between attacker and victim by IP and optional port.
- `unblock_ip.sh` — Unblocks the previously blocked traffic rules.

---

## 🚀 Usage

### 🔒 Blocking Traffic

```bash
cd suricata-wazuh-c2-detection-lab/response_scrpit 
sudo ./block_ip.sh

