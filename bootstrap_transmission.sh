#!/usr/bin/env bash

apt-get -y -m install build-essential libevent-dev intltool libssl-dev libcurl4-openssl-dev pkg-config zlib1g-dev

cd /tmp
wget https://github.com/transmission/transmission-releases/raw/master/transmission-3.00.tar.xz
tar -xvJf transmission-3.00.tar.xz
cd transmission-3.00

./configure
make
make install

adduser --disabled-password --shell `which bash` --gecos "transmission,," transmission

touch /var/log/transmission.log
chown transmission.transmission /var/log/transmission.log

cd /etc/systemd/system

wget https://raw.github.com/nick-desteffen/transmission-bootstrap/master/systemd/transmission-daemon.service

chmod 644 /etc/systemd/system/transmission-daemon.service
systemctl start transmission-daemon
systemctl enable transmission-daemon

/usr/local/bin/transmission-daemon --version

