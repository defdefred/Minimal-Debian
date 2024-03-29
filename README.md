# Minimal-debian

## Installation
Let's use `user` as username in this doc.
You can choose the username you want.

Install the less things possible; Use LUKS encrypted disk with a long sentence, misspelled words and numbers+special characters as password.

## Auto-configuration
```
root@wize:~# apt install wget
root@wize:~# wget https://tinyurl.com/Minimal-Debian
root@wize:~# ./Minimal-Debian
```

## Review configuration (optional)
### Living dangerously
Can't wait for month to have latest software version, so switching to "testing" debian version.
```
root@wize:~# cat /etc/apt/sources.list
deb http://deb.debian.org/debian testing main contrib non-free-firmware
deb http://deb.debian.org/debian-security/ testing-security main contrib non-free-firmware
deb http://deb.debian.org/debian testing-updates main contrib non-free-firmware
```
## Auto login
As the disk is Luks encrypted, the strong pass-phrase is asked at each boot and auto-login is welcome.
```
cat /etc/systemd/system/getty@tty1.service.d/override.conf
[Service]
ExecStart=
ExecStart=-/usr/sbin/agetty --autologin user --noclear %I $TERM
```
## Disable ipv6
```
root@wize:~# cat > /etc/sysctl.d/00-no-ipv6.conf
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 1
```
## Wifi/Ethernet
```
root@wize:~# ip a | grep BROADCAST
2: eth0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group default qlen 1000
3: lxcbr0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN group default qlen 1000
4: wlx0090c38eb690: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
7: enx020733313734: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group default qlen 1000
```
Ethernet is `eth0`
Wifi (USB) is `wlx0090c38eb690`
4G Phone (USB) is `enx020733313734`
This is my configuration, check yours.
```
root@wize:~# cat /etc/network/interfaces
# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

source /etc/network/interfaces.d/*

# The loopback network interface
auto lo
iface lo inet loopback

# wifi usb
allow-hotplug wlx0090c38eb690
auto wlx0090c38eb690
iface wlx0090c38eb690 inet dhcp
wpa-ssid "mySID"
wpa-psk  "mySECRET"

# 4G Phone usb
allow-hotplug enx020733313734
iface enx020733313734 inet dhcp

# The primary network interface (not used => commented)
#auto eth0
#iface eth0 inet dhcp
```
Get the [script](src/create_network_interface_template)
## Auto patching, etc.
Internet is a dangerous place on earth. Can't use it before properlly patching your debian, everyday. Auto patching, auto sound control and auto gui is only active in tty1, so ALT-F? switch to another console if you need pure cli access.

First, check what is manageable with `alsa`:
```
root@wize:~# amixer scontrols 
Simple mixer control 'Master',0
Simple mixer control 'Headphone',0
Simple mixer control 'Speaker',0
Simple mixer control 'PCM',0
Simple mixer control 'Mic',0
Simple mixer control 'Mic Boost',0
Simple mixer control 'Beep',0
Simple mixer control 'Capture',0
Simple mixer control 'Auto-Mute Mode',0
Simple mixer control 'Digital',0
Simple mixer control 'Loopback Mixing',0
```
Then adapt the bash profile script:
```
root@wize:~# cat /home/user/.bash_profile
if [ `tty` = /dev/tty1 ]
then
  if ping -c 1 -W 1 1.1.1.1
  then
    echo Net Ok
  else
    sudo /usr/sbin/ifdown -a
    sudo /usr/sbin/ifup -a
  fi
  sudo /usr/bin/apt update
  sudo /usr/bin/apt full-upgrade -y
  sudo /usr/bin/apt autoremove -y
  sudo /usr/bin/apt clean -y
  amixer sset Speaker 100%
  amixer sset Headphone 100%
  amixer sset PCM 100%
  amixer sset Master 50%
  [ -x "/usr/bin/weston" ] && weston
fi
```
Get the [script](src/create_bash_profile)
## Sudo
Users have rigths and duties
```
# cat /etc/sudoers.d/user
user ALL=(ALL) NOPASSWD: /usr/bin/apt update, /usr/bin/apt full-upgrade -y, /usr/bin/apt autoremove -y, /usr/bin/apt clean -y, /usr/sbin/ifdown -a, /usr/sbin/ifup -a
```
Get the [script](src/create_sudoers_d_user)

## Interface
Computosaure should stick with [Terminal](Terminal.md).

More recent computer could use graphical interface with [Wayland](Wayland.md).
