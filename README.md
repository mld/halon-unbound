Unbound and libldns for Halon SR
================================

This is a set of files and instructions for installing Unbound and libldns on Halon Security Router. Each set is packaged for a specific version of Halon SR. The current releases supported are (with tested patch levels in a nested list):
 * 3.1-fox
   * p5
 * 3.0-cookie (earlier release, please see https://github.com/mld/halon-unbound/tree/master/3.0-cookie for instructions)
   * p30
   * p32
   * p33

Halon Security Router
---------------------
  Halon Security's security router (SR) is a firewall/router software distribution based on OpenBSD. 
  The great majority of the system is open source. Read more att Halon Securitys web site: www.halon.se


Instructions
------------
Download https://github.com/mld/halon-unbound/blob/master/3.1-fox/unbound-install.sh and copy it to your SR, ie 

    ftp -o /cfg/unbound-install.sh https://github.com/mld/halon-unbound/blob/master/3.1-fox/unbound-install.sh
    chmod +x /cfg/unbound-install.sh
  
  Optionally, put your custom unbound.conf in /cfg/skel/unbound.conf
  
  Put the following in /cfg/skel/rc.local:
  
    /cfg/unbound-install.sh &

  This automatically downloads and installs Unbound and libldns at reboot, and optionally uses your custom unbound.conf.
