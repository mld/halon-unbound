#!/bin/ksh

if [[ "$(cat /etc/version | cut -d'-' -f1,2)" != "3.0-cookie" ]]; then 
	echo "This install script is for 3.0-cookie!"
	exit 1"
fi

groupadd -g 601 _unbound
useradd -m -d /var/unbound -g 601 -s /sbin/nologin -L daemon -c "Unbound Daemon" -u 601 _unbound

cd /usr/local
tar zxvf /cfg/unbound/unbound-bin.tgz
tar zxvf /cfg/unbound/unbound-sbin.tgz
tar zxvf /cfg/unbound/unbound-lib.tgz
tar zxvf /cfg/unbound/unbound-man.tgz
tar zxvf /cfg/unbound/unbound-share.tgz
tar zxvf /cfg/unbound/unbound-include.tgz

#install -d -m 0755 /var/unbound/dev
#install -d -m 0755 /var/unbound/etc
#install -d -m 0775 -g 601 /var/unbound/var/run

install -m 0555 /cfg/unbound/etc/rc.d/unbound /etc/rc.d/unbound

chmod 0755 /usr/local/sbin/unbound
chmod 0755 /usr/local/sbin/unbound-anchor
chmod 0755 /usr/local/sbin/unbound-checkconf
chmod 0755 /usr/local/sbin/unbound-control
chmod 0755 /usr/local/sbin/unbound-control-setup
chmod 0755 /usr/local/sbin/unbound-host
chmod 0755 /usr/local/bin/ldns-config

echo "Unbound installed"
