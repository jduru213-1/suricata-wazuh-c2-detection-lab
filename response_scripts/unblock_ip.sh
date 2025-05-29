#!/bin/bash

echo "                        "

echo "------------------------"
echo "     Unblock Script     "
echo "------------------------"

echo "                        "

read -p "Enter Malicious IP: " ATTACKER_IP
read -p "Enter Victim IP: " VICTIM_IP
read -p "Enter victim port to unblock (leave empty to unblock all ports): " PORT

if [[ -z "$ATTACKER_IP" || -z "$VICTIM_IP" ]]; then
  echo "[-] Missing input(s). Exiting."
  exit 1
fi

echo "[*] Unblocking traffic from $ATTACKER_IP to $VICTIM_IP..."

if [[ -z "$PORT" ]]; then
  # Unblock all ports/protocols between the IPs
  sudo iptables -D FORWARD -s "$ATTACKER_IP" -d "$VICTIM_IP" -j DROP
  sudo iptables -D FORWARD -s "$VICTIM_IP" -d "$ATTACKER_IP" -j DROP
  echo "[+] All traffic between $ATTACKER_IP and $VICTIM_IP has been unblocked."
else
  # Unblock only specified port (TCP)
  sudo iptables -D FORWARD -p tcp --dport "$PORT" -s "$ATTACKER_IP" -d "$VICTIM_IP" -j DROP
  sudo iptables -D FORWARD -p tcp --dport "$PORT" -s "$VICTIM_IP" -d "$ATTACKER_IP" -j DROP
  echo "[+] Traffic on port $PORT between $ATTACKER_IP and $VICTIM_IP has been unblocked."
fi

echo "[*] Unblock operation completed successfully."

