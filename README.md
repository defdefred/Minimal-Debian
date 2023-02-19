# Minimal-debian

## Username
Let's use `user` as username in this doc.

## Minimal Debian
Install the less things possible; Use LUKS encrypted disk with a long sentence, misspelled words and numbers+special characters as password.

## Living dangerously
Can't wait for month to have latest software version, so switching to "testing" debian version.
```
# cat /etc/apt/sources.list
deb http://deb.debian.org/debian/ testing main non-free contrib
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
```
root@wize:~# $ cat /etc/network/interfaces
# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

source /etc/network/interfaces.d/*

# The loopback network interface
auto lo
iface lo inet loopback

# wifi
allow-hotplug wlx0090c38eb690
auto wlx0090c38eb690
iface wlx0090c38eb690 inet dhcp
wpa-ssid "mySID"
wpa-psk  "mySECRET"

# 4G Phone
allow-hotplug enx020733313734
iface enx020733313734 inet dhcp

# The primary network interface (not used => commented)
#auto eth0
#iface eth0 inet dhcp
```
## Auto patching, etc.
Internet is a dangerous place on earth. Can't use it before properlly patching your debian, everyday. Auto patching, auto sound control and auto gui is only active in tty1, so ALT-F? switch to another console if you need pure cli access.
```
su - user -c "cat > .bash_profile"
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
## Sudo
Users have rigths and duties
```
# cat /etc/sudoers.d/user
user ALL=(ALL) NOPASSWD: /usr/bin/apt update, /usr/bin/apt full-upgrade -y, /usr/bin/apt autoremove -y, /usr/bin/apt clean -y, /usr/sbin/ifdown -a, /usr/sbin/ifup -a
```
## Interface
Computosaure should stick with [Terminal](Terminal.md).

More recent computer could use graphical interface with [Wayland](Wayland.md).
