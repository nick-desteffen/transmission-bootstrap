#!/usr/bin/env bash

apt-get -y -m install build-essential libevent-dev intltool libssl-dev libcurl4-openssl-dev pkg-config

cd /tmp
wget https://github.com/transmission/transmission-releases/raw/master/transmission-2.94.tar.xz
tar -xvJf transmission-2.94.tar.xz
cd transmission-2.94

./configure
make
make install

adduser --disabled-password --shell `which bash` --gecos "transmission,," transmission

touch /var/log/transmission.log
chown transmission.transmission /var/log/transmission.log

cd /etc/init.d
wget https://raw.github.com/nick-desteffen/transmission-bootstrap/master/init.d/transmission-daemon
chmod +x /etc/init.d/transmission-daemon

update-rc.d transmission-daemon defaults

cd /home/transmission
wget https://raw.github.com/nick-desteffen/transmission-bootstrap/master/auto-unrar.sh

/usr/local/bin/transmission-daemon --version

