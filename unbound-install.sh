#!/bin/ksh

MIRROR="http://ftp.eu.openbsd.org/pub/OpenBSD"
PKG_CACHE=/data/pkg_cache
mkdir -p $PKG_CACHE

install_perl() {
	# Check if Perl is installed already
	[ -d /usr/libdata/perl5 ] && return 0

	cd /data
	# Download missing files
	[ ! -f SHA256.sig ] && ftp $BASEURL/SHA256.sig
	[ ! -f $BASENAME  ] && ftp $BASEURL/$BASENAME

	mount -uw /
	signify -C -p /etc/signify/$PUBKEY -x SHA256.sig $BASENAME && tar -xzpf $BASENAME -C / ./usr/libdata/perl5
	mount -ur /

	echo "Perl installed"
}

install_unbound() {
	mount -uw /
	if [ ! -d /var/unbound/etc ]; then
		mkdir -p /var/unbound
		mount_mfs -o nodev,nosuid -i 128 -s 4096 swap /var/unbound
	fi
	pkg_delete -I unbound
	pkg_add -I unbound
	mount -ur /
	[ -f /cfg/skel/unbound.conf ] && cp /cfg/skel/unbound.conf /var/unbound/etc/unbound.conf
	/usr/local/sbin/unbound-anchor -a "/var/unbound/etc/root.key"
	ftp -a -o /var/unbound/etc/named.cache ftp://ftp.internic.net/domain/named.cache
	/usr/local/sbin/unbound-control-setup
	/usr/local/sbin/unbound -c /var/unbound/etc/unbound.conf

	echo "Unbound installed"
}

VERSION=$(cat /etc/version | cut -d'-' -f1)

case $VERSION in
	3.3)
		BASEURL=$MIRROR/5.5/`uname -m`
		BASENAME=base55.tgz
		PUBKEY=openbsd-55-base.pub
		install_perl
		install_unbound
		;;
	3.2|3.1)
		install_unbound
		;;
	*)
		echo "You are running an unsupported version of Halon SR."
		echo "Please create an issue at https://github.com/mld/halon-unbound/issues"
		exit 1
esac
