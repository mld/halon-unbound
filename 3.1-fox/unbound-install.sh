#!/bin/ksh

if [[ "$(cat /etc/version | cut -d'-' -f1,2)" != "3.1-fox" ]]; then 
	echo "This install script is for 3.1-fox!"
	exit 1
fi

mount -uw /
mkdir /var/unbound
mount_mfs -o nodev,nosuid -i 128 -s 4096 swap /var/unbound
pkg_add unbound
mount -ur /
if [[ -f /cfg/skel/unbound.conf ]]; then cp /cfg/skel/unbound.conf /var/unbound/etc/unbound.conf; fi
/usr/local/sbin/unbound-anchor -a "/var/unbound/etc/root.key"
ftp -a -o /var/unbound/etc/named.cache ftp://ftp.internic.net/domain/named.cache
/usr/local/sbin/unbound-control-setup
/usr/local/sbin/unbound -c /var/unbound/etc/unbound.conf

echo "Unbound installed"
