# Minimal-debian

## Username
Let's use `user` as username in this doc.

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
## Auto patching
Internet is a dangerous place in earth. Can't use it before proper patching your debian, everyday. Auto patching and auto gui is only active in tty1 so switch  to other console if you need pure cli access.
```
su - user -c "cat > .bash_profile"
if [ `tty` = /dev/tty1 ]
then
        if ping -c 1 -W 1 1.1.1.1
        then
                sudo /usr/bin/apt-get update -y
                sudo /usr/bin/apt-get upgrade -y
        fi
        sudo /usr/bin/apt-get autoremove -y
        sudo /usr/bin/apt-get clean -y
        exec gui
fi
```
## Sudo
Users have rigths and dutie
```
# cat /etc/sudoers.d/user
user ALL=(ALL) NOPASSWD: /usr/bin/apt-get update -y, /usr/bin/apt-get upgrade -y, /usr/bin/apt-get autoremove -y, /usr/bin/apt-get clean -y
```
## Gui
You can use Xorg or Wayland
```
# cat /home/user/gui
exec startx
```
