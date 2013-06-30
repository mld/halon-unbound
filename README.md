Unbound and libldns for Halon SR
================================

This is a set of files and instructions for installing Unbound and libldns. Each set is packaged for a specific version of Halon SR. The current releases supported are (with tested patch levels in a nested list):
 * 3.0-cookie
   * p30
   * p32
   * p33

Halon Security Router
---------------------
  Halon Security's security router (SR) is a firewall/router software distribution based on OpenBSD. 
  The great majority of the system is open source. Read more att Halon Securitys web site: www.halon.se


Instructions
------------
Put all files in /cfg/halon-unbound-3.0-cookie
  
Run 

    ln -s /cfg/halon-unbound-3.0-cookie/ /cfg/unbound
  
  Put the following in /cfg/skel/rc.local:
  
    mkdir /var/unbound
    mount_mfs -o nodev,nosuid -i 128 -s 4096 -P /cfg/unbound/unbound.skel/ swap /var/unbound
    mount -uw /
    /cfg/unbound/install.sh
    mount -ur /
    /usr/local/sbin/unbound-anchor -a "/var/unbound/etc/root.key"
    /usr/local/sbin/unbound -c /var/unbound/etc/unbound.conf
