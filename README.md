# moyo-router-config

```bash
sudo -i
apt update
apt install ifupdown isc-dhcp-server wireguard iptables-persistent hostapd
systemctl unmask networking
systemctl enable networking

adduser menhera
adduser menhera sudo
mkdir -p -m 0700 /home/menhera/.ssh
vi /home/menhera/.ssh/authorized_keys
chown -R menhera: /home/menhera/.ssh

hostnamectl set-hostname ro01 # or moyo-router

vi /etc/sysctl.d/99-proxy-arp.conf
vi /etc/sysctl.d/99-router.conf
sysctl --system

vi /etc/iptables/rules.v4
iptables-restore < /etc/iptables/rules.v4

( umask 077 ; wg genkey > /etc/wireguard/wg150.key ; )

# add GPG key
curl -s https://deb.frrouting.org/frr/keys.asc | apt-key add -

# possible values for FRRVER: frr-6 frr-7 frr-8 frr-stable
# frr-stable will be the latest official stable release
FRRVER="frr-stable"
echo deb https://deb.frrouting.org/frr $(lsb_release -s -c) $FRRVER | tee -a /etc/apt/sources.list.d/frr.list

# update and install FRR
apt update && sudo apt install frr frr-pythontools

vi /etc/frr/daemons
systemctl restart frr

vtysh

lxd init
# create network = no
# default network = br-menhera

lxc init ubuntu:22.04 moyo-server
lxc config show moyo-server
# copy MAC address to /etc/dhcp/dhcpd.conf
lxc config set moyo-server security.privileged true
lxc config set moyo-server security.nesting true
lxc start moyo-server
lxc shell moyo-server
# vi /home/ubuntu/.ssh/authorized_keys
# passwd ubuntu
```
