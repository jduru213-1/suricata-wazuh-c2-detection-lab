#!/bin/bash

# Block malicious traffic between attacker and victim IPs on specific port (TCP)

echo "                         " 
echo "-------------------------"
echo "      Block Script"
echo "-------------------------"
echo "                         "

read -p "Enter Malicious IP: " ATTACKER_IP
read -p "Enter Victim IP: " VICTIM_IP
read -p "Enter victim port to block (leave empty to block all ports): " PORT

if [[ -z "$ATTACKER_IP" || -z "$VICTIM_IP"  ]]; then
  echo "[-] Missing input(s). Exiting."
  exit 1
fi

echo "[*] Blocking  traffic from $ATTACKER_IP to $VICTIM_IP"

if [[ -z "$PORT" ]]; then
  # Block all ports/protocols between the IPs
  sudo iptables -A FORWARD -s "$ATTACKER_IP" -d "$VICTIM_IP" -j DROP
  sudo iptables -A FORWARD -s "$VICTIM_IP" -d "$ATTACKER_IP" -j DROP
  echo "[+] All traffic between $ATTACKER_IP and $VICTIM_IP has been blocked."
else
  # Block only specified port (TCP)
  sudo iptables -A FORWARD -p tcp --dport "$PORT" -s "$ATTACKER_IP" -d "$VICTIM_IP" -j DROP
  sudo iptables -A FORWARD -p tcp --dport "$PORT" -s "$VICTIM_IP" -d "$ATTACKER_IP" -j DROP
  echo "[+] Traffic on port $PORT between $ATTACKER_IP and $VICTIM_IP has been blocked."
fi

echo "[+] Malicous Trafifc from $ATTACKER_IP to $VICTIM_IP has been blocked successfully."
