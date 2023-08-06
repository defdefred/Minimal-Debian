#!/bin/bash

USER=/home/*

apt install -y alsa-utils sudo

cat > /etc/sysctl.d/00-no-ipv6.conf << EOT
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 1
EOT
echo "ipv6 disabled"

cat > /etc/apt/sources.list << EOT
deb http://deb.debian.org/debian testing main contrib non-free-firmware
deb http://deb.debian.org/debian-security/ testing-security main contrib non-free-firmware
deb http://deb.debian.org/debian testing-updates main contrib non-free-firmware
EOT
echo "Apt sources configured"

cat > /home/$USER/.bash_profile << EOT
if [ \`tty\` = /dev/tty1 ]
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
  if [ -x "/usr/bin/weston" ]
  then
    weston
  elif [ -x /usr/sbin/startx ]
    then
      /usr/sbin/startx 
    fi
  fi
fi
EOT
echo "Auto upgrade, sound level, configured"

cat > /etc/sudoers.d/$USER << EOT
$USER ALL=(ALL) NOPASSWD: /usr/bin/apt update, /usr/bin/apt full-upgrade -y, /usr/bin/apt autoremove -y, /usr/bin/apt clean -y, /usr/sbin/ifdown -a, /usr/sbin/ifup -a
EOT
echo "Sudo granted"

