#!/usr/bin/env bash

apt-get -y -m install build-essential libevent-dev intltool libssl-dev libcurl4-openssl-dev

cd /tmp
wget http://download.transmissionbt.com/files/transmission-2.92.tar.xz
tar xvJf transmission-2.92.tar.xz
cd transmission-2.92

./configure
make
make install

adduser --disabled-password --shell `which bash` --gecos "transmission,," transmission

cd /etc/init.d
wget https://raw.github.com/nick-desteffen/transmission-bootstrap/master/init.d/transmission-daemon
chmod +x /etc/init.d/transmission-daemon

update-rc.d transmission-daemon defaults

/usr/local/bin/transmission-daemon --version
