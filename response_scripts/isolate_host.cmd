@echo off
echo [*] Isolating host from network...

:: Enable firewall and block all outbound and inbound connections
netsh advfirewall set allprofiles state on
netsh advfirewall set allprofiles firewallpolicy blockoutbound, blockinbound

echo [+] Host is now isolated from the network.
pause
