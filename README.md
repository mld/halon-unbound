Unbound and libldns for Halon SR
================================

This is an install script and instructions for installing Unbound and libldns on Halon Security Router. 
The current supported releases are (with tested patch levels in a nested list):
 * 3.3
   * p1
   * p2
 * 3.2
 * 3.1

Halon Security Router
---------------------
  Halon Security's security router (SR) is a firewall/router software distribution based on OpenBSD. 
  The great majority of the system is open source. Read more att Halon Securitys web site: www.halon.se

Requirements
------------
 * A supported version of SR (see above)
 * /data partition with at least 64MB free space (base55.tar.gz et al)
 * root access to your SR

Instructions
------------
Download https://github.com/mld/halon-unbound/blob/master/unbound-install.sh and copy it to your SR, ie 

    ftp -o /cfg/unbound-install.sh https://github.com/mld/halon-unbound/blob/master/unbound-install.sh
    chmod +x /cfg/unbound-install.sh
  
  Optionally, put your custom unbound.conf in /cfg/skel/unbound.conf
  
  Put the following in /cfg/skel/rc.local:
  
    /cfg/unbound-install.sh &

  This automatically downloads and installs Perl from OpenBSD base package and Unbound with dependencies 
  at reboot, and optionally uses your custom unbound.conf (placed in /cfg/skel/unbound.conf).
