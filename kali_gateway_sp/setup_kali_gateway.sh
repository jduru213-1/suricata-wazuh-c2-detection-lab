#!/bin/bash

# 🛑 Make sure the script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "❌ Please run this script with sudo or as root."
  exit 1
fi

echo "✅ Step 1: Enabling IP forwarding..."

# Add the setting to the sysctl config file (if not already there)
if ! grep -q "net.ipv4.ip_forward=1" /etc/sysctl.conf; then
  echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
  echo "✔️ Added net.ipv4.ip_forward=1 to /etc/sysctl.conf"
else
  echo "ℹ️ IP forwarding already set in /etc/sysctl.conf"
fi

# Apply the changes
sysctl -p

# Enable it temporarily (takes effect immediately)
echo 1 > /proc/sys/net/ipv4/ip_forward
sysctl -w net.ipv4.ip_forward=1

echo "✅ Step 2: Setting up NAT using eth2 (the internet interface)..."
iptables -t nat -A POSTROUTING -o eth2 -j MASQUERADE

echo "✅ Step 3: Allowing traffic from vmnet1 and vmnet2 to go through eth2..."
iptables -A FORWARD -i vmnet1 -o eth2 -j ACCEPT
iptables -A FORWARD -i vmnet2 -o eth2 -j ACCEPT

echo "✅ Step 4: Installing iptables-persistent (if not already installed)..."
apt update
apt install -y iptables-persistent

echo "💾 Saving iptables rules so they apply after reboot..."
netfilter-persistent save

echo "🎉 All done! Your Kali Linux box is now acting as a gateway router."
