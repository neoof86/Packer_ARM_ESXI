#!/bin/bash

echo '> Cleaning all audit logs ...'
if [ -f /var/log/audit/audit.log ]; then
cat /dev/null > /var/log/audit/audit.log
fi
if [ -f /var/log/wtmp ]; then
cat /dev/null > /var/log/wtmp
fi
if [ -f /var/log/lastlog ]; then
cat /dev/null > /var/log/lastlog
fi
# Cleans SSH keys.
echo '> Cleaning SSH keys ...'
rm -f /etc/ssh/ssh_host_*
# Sets hostname to localhost.
echo '> Setting hostname to localhost ...'
cat /dev/null > /etc/hostname
hostnamectl set-hostname localhost
# Cleans apt-get.
echo '> Cleaning apt-get ...'
apt-get clean
# Cleans the machine-id.
echo '> Cleaning the machine-id ...'
truncate -s 0 /etc/machine-id
rm /var/lib/dbus/machine-id
ln -s /etc/machine-id /var/lib/dbus/machine-id
# Set DHCP to MAC
sed -i "s/dhcp4: true/&\n      dhcp-identifier: mac/" /etc/netplan/00-installer-config.yaml
# Regen Keys on next boot
echo '> Setting check for ssh keys on reboot; will regenerate on reboot if neccessary. ...'
sudo tee /etc/rc.local << EOF
#!/bin/bash
test -f /etc/ssh/ssh_host_dsa_key || dpkg-reconfigure -f noninteractive openssh-server
exit 0
EOF
sudo chmod +x /etc/rc.local
