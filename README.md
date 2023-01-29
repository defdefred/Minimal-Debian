# Minimal-debian

## Username
Let's use `user` as username in this doc.

## Minimal Debian
Install the less things as possible; Use LUKS encrypted disk with a long sentence with misspelled words and numbers+special characters as password.

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

## Auto patching
Internet is a dangerous place on earth. Can't use it before proper patching your debian, everyday. Auto patching and auto gui is only active in tty1, so ALT-F? switch to another console if you need pure cli access.
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
  sudo /usr/bin/apt update -y
  sudo /usr/bin/apt full-upgrade -y
  sudo /usr/bin/apt autoremove -y
  sudo /usr/bin/apt clean -y
  exec gui
fi
```
## Sudo
Users have rigths and duties
```
# cat /etc/sudoers.d/user
user ALL=(ALL) NOPASSWD: /usr/bin/apt update, /usr/bin/apt full-upgrade -y, /usr/bin/apt autoremove -y, /usr/bin/apt clean -y, /usr/sbin/ifdown -a, /usr/sbin/ifup -a
```
## Choose an interface
Computosaure should stick with [Terminal](Terminal.md).
More recent computer could use graphical interface with [Wayland](Wayland.md).
## Gui
You can use Xorg or Wayland
```
# cat /home/user/gui
exec startx
```
