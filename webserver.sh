#!/bin/bash
#
# LetsEncrypt testing.
#
# https://www.tenormanmike.com/website-and-hosting-issues/how-to-install-a-lets-encrypt-ssl-on-a-shared-godaddy-hosting-account/
#
# Easy way to create a cert for an existing web server (--manual) using ZeroSSL's web interface.
# To renew, copy and paste in the CSR.
# https://zerossl.com/
#
# DNS method via the above web site.
#
# Create the TXT record in DNS. On Godaddy, omit the .eadgbe.net domain in the record. Example:
#
# Host                  TXT
# _acme-challenge.triad 9GAGvZCW86S_SX4_y0Yjy220Ffdw3X6jYSOBiWo

# DNS method via command line:

docker run -it --rm --name certbot docker.io/certbot/certbot certonly --manual --preferred-challenges dns --email bkozdemba@gmail.com -d presto.eadgbe.net --agree-tos --dry-run

# https://certbot.eff.org/docs/using.html#plugins

# Manual method from a docker container. It will geneate the challenge key and filename that you need to 
# put into a working web server's directory. The certs are created in the container so the /etc/letsencrypt directory must
# be copied or host mounted to save the certs.

# docker run -it --rm --name certbot docker.io/certbot/certbot certonly --manual --preferred-challenges http --email bkozdemba@gmail.com -d presto.eadgbe.net --agree-tos --dry-run

# Renewal - This will command will examine /etc/letsencrypt on the host for exsiting certs and renew ones that are aproaching expiration.
# docker run -it --rm --name certbot -v /etc/letsencrypt:/etc/letsencrypt docker.io/certbot/certbot renew

Last login: Sun Sep 23 00:24:50 on ttys001
allegro:~ koz$ ssh triad
Last login: Sun Sep 23 00:50:19 2018 from 72.177.93.176
[bkozdemb@triad ~]$ sudo -i
[root@triad ~]# ls
anaconda-ks.cfg  Documents            letsencrypt.sh   Pictures        run-mysql.sh   run-registry.sh         Videos
app_keys         Downloads            letsencrypt.txt  Public          run-nexus.sh   run-workshopper.sh
backup.sh        etc-letsencrypt.bak  Music            run-elastic.sh  run-ocp.sh     Templates
Desktop          grub2-theme-breeze   nexus-functions  run-gitlab.sh   run-piwigo.sh  v310-aws-gluster.hosts
[root@triad ~]# cd /etc/letsencrypt/archive/
[root@triad archive]# ls
apps.koz.redhatgov.io  apps.koz.redhatgov.io-0001  openshift.koz.redhatgov.io  reg.koz.redhatgov.io  triad.eadgbe.net
[root@triad archive]# cd triad.eadgbe.net/
[root@triad triad.eadgbe.net]# ls
cert1.pem  chain1.pem  fullchain1.pem  privkey1.pem
[root@triad triad.eadgbe.net]# logout
[bkozdemb@triad ~]$ ls
 accts                                        KOZDB-20180831-201809180436-1006925667.pdf
 bin                                          media
 bk1965.jpg                                   mpsChromeBookFiles
 bk1965.pdf                                   Music
 chuckLeob                                    Pictures
 dallas-credit.txt                            Public
 data                                         public_html
 Desktop                                      rh
 disconnected                                 securityPitch.txt
 docs                                         src
 Documents                                    stompinAtTheSavoy.mp3
 Downloads                                    Templates
 fallsChurchMarriott-386-98.pdf               v310.hosts
 flyingCarpetsWithMetro.mp3                   Vagabond-Blues-Bass.jpg
 git                                          Vagabond-Blues-C-Instruments.jpg
 graphics                                     Videos
 jaredJuly8_2018.pdf                         'VirtualBox VMs'
 kieselAC375receipt.pdf                       washingtonTheatreFrankVinnyTickets.pdf
 KOZDB-20180531-201806261142-1710227623.pdf  'www.NewAlbumReleases.net_Nels_Cline_and_Julian_Lage_-_Room_(2014).rar'
[bkozdemb@triad ~]$ cd src/
/home/bkozdemb/src
[bkozdemb@triad src]$ ls
ab-docker          cgbuddy-1.0.tar.gz  gittest            jboss-eap-quickstarts  mongo                  pi.c           ticket-monster
ansible            cg-gui              gnome-extensions   jboss-scanner          mongodb                pthreads       timeValue
ansible-container  cinnamon            go                 kibana                 mongodbclient          python         tmuxinator
ansible-playbooks  cs291-koz           gogs-repositories  kml                    mpi                    ravello        tomcat
atomic             docker              golang             kmod-programming       NetBeansProjects       redhat         tomcatbinbg
baseball           docker-alfresco     googleMaps         larryUllmanBooks       node                   restful        vagrant
BeerShift          fabric8             gtk                launchpad              openshift              ricksFileDiff  vtk
BeerShiftWeb       fileio              hadoop             ldap                   openshift-quickstarts  smpray         web
bookstore          fuse                hw                 mariadb                openshift-workshops    springboot     X11
branchtest         gce                 impress.js         math                   openstreetmap          sql            yubinano
c++                git                 istio-workshop     maven                  oracle                 summit2017
certs              github.com          java               memory                 petsets                systemd
cgbuddy-1.0        gitlab              javascript         mmix                   php                    templates
[bkozdemb@triad src]$ cd mkdir letsenscript
-bash: cd: too many arguments
[bkozdemb@triad src]$  mkdir letsenscript
[bkozdemb@triad src]$ ls
ab-docker          cgbuddy-1.0.tar.gz  gittest            jboss-eap-quickstarts  mmix                   php            templates
ansible            cg-gui              gnome-extensions   jboss-scanner          mongo                  pi.c           ticket-monster
ansible-container  cinnamon            go                 kibana                 mongodb                pthreads       timeValue
ansible-playbooks  cs291-koz           gogs-repositories  kml                    mongodbclient          python         tmuxinator
atomic             docker              golang             kmod-programming       mpi                    ravello        tomcat
baseball           docker-alfresco     googleMaps         larryUllmanBooks       NetBeansProjects       redhat         tomcatbinbg
BeerShift          fabric8             gtk                launchpad              node                   restful        vagrant
BeerShiftWeb       fileio              hadoop             ldap                   openshift              ricksFileDiff  vtk
bookstore          fuse                hw                 letsenscript           openshift-quickstarts  smpray         web
branchtest         gce                 impress.js         mariadb                openshift-workshops    springboot     X11
c++                git                 istio-workshop     math                   openstreetmap          sql            yubinano
certs              github.com          java               maven                  oracle                 summit2017
cgbuddy-1.0        gitlab              javascript         memory                 petsets                systemd
[bkozdemb@triad src]$ cd letsenscript/
/home/bkozdemb/src/letsenscript
[bkozdemb@triad letsenscript]$ ls
[bkozdemb@triad letsenscript]$ mkdir triad.eadgbe.net
[bkozdemb@triad letsenscript]$ cd triad.eadgbe.net/
/home/bkozdemb/src/letsenscript/triad.eadgbe.net
[bkozdemb@triad triad.eadgbe.net]$ ls
[bkozdemb@triad triad.eadgbe.net]$ vim triad-eadgbe.net.csr
[bkozdemb@triad triad.eadgbe.net]$ vim triad-eadgbe.net-key.pem
[bkozdemb@triad triad.eadgbe.net]$ nslookup -q _acme-challenge.triad.eadgbe.net -txt
*** Invalid option: q
*** Invalid option: txt
Server:		127.0.0.1
Address:	127.0.0.1#53

** server can't find _acme-challenge.triad.eadgbe.net: NXDOMAIN

[bkozdemb@triad triad.eadgbe.net]$ nslookup -q TXT _acme-challenge.triad.eadgbe.net 
*** Invalid option: q
nslookup: couldn't get address for '_acme-challenge.triad.eadgbe.net': not found
[bkozdemb@triad triad.eadgbe.net]$ nslookup -q=TXT _acme-challenge.triad.eadgbe.net 
Server:		127.0.0.1
Address:	127.0.0.1#53

** server can't find _acme-challenge.triad.eadgbe.net: NXDOMAIN

[bkozdemb@triad triad.eadgbe.net]$ nslookup triad.eadgbe.net
Server:		127.0.0.1
Address:	127.0.0.1#53

Non-authoritative answer:
Name:	triad.eadgbe.net
Address: 72.177.93.176

[bkozdemb@triad triad.eadgbe.net]$ sudo -i
[root@triad ~]# docker run -it --rm --name certbot -v /etc/letsencrypt:/etc/letsencrypt docker.io/certbot/certbot renew
Saving debug log to /var/log/letsencrypt/letsencrypt.log

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Processing /etc/letsencrypt/renewal/openshift.koz.redhatgov.io.conf
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Renewal configuration file /etc/letsencrypt/renewal/openshift.koz.redhatgov.io.conf (cert: openshift.koz.redhatgov.io) produced an unexpected error: 'Namespace' object has no attribute 'dns_route53_propagation_seconds'. Skipping.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Processing /etc/letsencrypt/renewal/apps.koz.redhatgov.io.conf
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Renewal configuration file /etc/letsencrypt/renewal/apps.koz.redhatgov.io.conf (cert: apps.koz.redhatgov.io) produced an unexpected error: 'Namespace' object has no attribute 'dns_route53_propagation_seconds'. Skipping.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Processing /etc/letsencrypt/renewal/apps.koz.redhatgov.io-0001.conf
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Renewal configuration file /etc/letsencrypt/renewal/apps.koz.redhatgov.io-0001.conf (cert: apps.koz.redhatgov.io-0001) produced an unexpected error: 'Namespace' object has no attribute 'dns_route53_propagation_seconds'. Skipping.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Processing /etc/letsencrypt/renewal/reg.koz.redhatgov.io.conf
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Renewal configuration file /etc/letsencrypt/renewal/reg.koz.redhatgov.io.conf (cert: reg.koz.redhatgov.io) produced an unexpected error: 'Namespace' object has no attribute 'dns_route53_propagation_seconds'. Skipping.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Processing /etc/letsencrypt/renewal/triad.eadgbe.net.conf
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Cert is due for renewal, auto-renewing...
Could not choose appropriate plugin: The manual plugin is not working; there may be problems with your existing configuration.
The error was: PluginError('An authentication script must be provided with --manual-auth-hook when using the manual plugin non-interactively.',)
Attempting to renew cert (triad.eadgbe.net) from /etc/letsencrypt/renewal/triad.eadgbe.net.conf produced an unexpected error: The manual plugin is not working; there may be problems with your existing configuration.
The error was: PluginError('An authentication script must be provided with --manual-auth-hook when using the manual plugin non-interactively.',). Skipping.
All renewal attempts failed. The following certs could not be renewed:
  /etc/letsencrypt/live/triad.eadgbe.net/fullchain.pem (failure)

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

All renewal attempts failed. The following certs could not be renewed:
  /etc/letsencrypt/live/triad.eadgbe.net/fullchain.pem (failure)

Additionally, the following renewal configuration files were invalid: 
  /etc/letsencrypt/renewal/openshift.koz.redhatgov.io.conf (parsefail)
  /etc/letsencrypt/renewal/apps.koz.redhatgov.io.conf (parsefail)
  /etc/letsencrypt/renewal/apps.koz.redhatgov.io-0001.conf (parsefail)
  /etc/letsencrypt/renewal/reg.koz.redhatgov.io.conf (parsefail)
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
1 renew failure(s), 4 parse failure(s)
[root@triad ~]# docker run -it --rm --name certbot -v /etc/letsencrypt:/etc/letsencrypt docker.io/certbot/certbot renew --dryrun
usage: 
  certbot [SUBCOMMAND] [options] [-d DOMAIN] [-d DOMAIN] ...

Certbot can obtain and install HTTPS/TLS/SSL certificates.  By default,
it will attempt to use a webserver both for obtaining and installing the
certificate. 
certbot: error: unrecognized arguments: --dryrun
[root@triad ~]# docker run -it --rm --name certbot -v /etc/letsencrypt:/etc/letsencrypt docker.io/certbot/certbot renew --dry-run
Saving debug log to /var/log/letsencrypt/letsencrypt.log

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Processing /etc/letsencrypt/renewal/openshift.koz.redhatgov.io.conf
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Renewal configuration file /etc/letsencrypt/renewal/openshift.koz.redhatgov.io.conf (cert: openshift.koz.redhatgov.io) produced an unexpected error: 'Namespace' object has no attribute 'dns_route53_propagation_seconds'. Skipping.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Processing /etc/letsencrypt/renewal/apps.koz.redhatgov.io.conf
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Renewal configuration file /etc/letsencrypt/renewal/apps.koz.redhatgov.io.conf (cert: apps.koz.redhatgov.io) produced an unexpected error: 'Namespace' object has no attribute 'dns_route53_propagation_seconds'. Skipping.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Processing /etc/letsencrypt/renewal/apps.koz.redhatgov.io-0001.conf
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Renewal configuration file /etc/letsencrypt/renewal/apps.koz.redhatgov.io-0001.conf (cert: apps.koz.redhatgov.io-0001) produced an unexpected error: 'Namespace' object has no attribute 'dns_route53_propagation_seconds'. Skipping.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Processing /etc/letsencrypt/renewal/reg.koz.redhatgov.io.conf
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Renewal configuration file /etc/letsencrypt/renewal/reg.koz.redhatgov.io.conf (cert: reg.koz.redhatgov.io) produced an unexpected error: 'Namespace' object has no attribute 'dns_route53_propagation_seconds'. Skipping.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Processing /etc/letsencrypt/renewal/triad.eadgbe.net.conf
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Cert is due for renewal, auto-renewing...
Could not choose appropriate plugin: The manual plugin is not working; there may be problems with your existing configuration.
The error was: PluginError('An authentication script must be provided with --manual-auth-hook when using the manual plugin non-interactively.',)
Attempting to renew cert (triad.eadgbe.net) from /etc/letsencrypt/renewal/triad.eadgbe.net.conf produced an unexpected error: The manual plugin is not working; there may be problems with your existing configuration.
The error was: PluginError('An authentication script must be provided with --manual-auth-hook when using the manual plugin non-interactively.',). Skipping.
All renewal attempts failed. The following certs could not be renewed:
  /etc/letsencrypt/live/triad.eadgbe.net/fullchain.pem (failure)

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
** DRY RUN: simulating 'certbot renew' close to cert expiry
**          (The test certificates below have not been saved.)

All renewal attempts failed. The following certs could not be renewed:
  /etc/letsencrypt/live/triad.eadgbe.net/fullchain.pem (failure)

Additionally, the following renewal configuration files were invalid: 
  /etc/letsencrypt/renewal/openshift.koz.redhatgov.io.conf (parsefail)
  /etc/letsencrypt/renewal/apps.koz.redhatgov.io.conf (parsefail)
  /etc/letsencrypt/renewal/apps.koz.redhatgov.io-0001.conf (parsefail)
  /etc/letsencrypt/renewal/reg.koz.redhatgov.io.conf (parsefail)
** DRY RUN: simulating 'certbot renew' close to cert expiry
**          (The test certificates above have not been saved.)
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
1 renew failure(s), 4 parse failure(s)
[root@triad ~]# docker run -it --rm --name certbot -v /etc/letsencrypt:/etc/letsencrypt docker.io/certbot/certbot renew --dry-run --preferred-challenges http
Saving debug log to /var/log/letsencrypt/letsencrypt.log

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Processing /etc/letsencrypt/renewal/openshift.koz.redhatgov.io.conf
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Renewal configuration file /etc/letsencrypt/renewal/openshift.koz.redhatgov.io.conf (cert: openshift.koz.redhatgov.io) produced an unexpected error: 'Namespace' object has no attribute 'dns_route53_propagation_seconds'. Skipping.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Processing /etc/letsencrypt/renewal/apps.koz.redhatgov.io.conf
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Renewal configuration file /etc/letsencrypt/renewal/apps.koz.redhatgov.io.conf (cert: apps.koz.redhatgov.io) produced an unexpected error: 'Namespace' object has no attribute 'dns_route53_propagation_seconds'. Skipping.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Processing /etc/letsencrypt/renewal/apps.koz.redhatgov.io-0001.conf
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Renewal configuration file /etc/letsencrypt/renewal/apps.koz.redhatgov.io-0001.conf (cert: apps.koz.redhatgov.io-0001) produced an unexpected error: 'Namespace' object has no attribute 'dns_route53_propagation_seconds'. Skipping.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Processing /etc/letsencrypt/renewal/reg.koz.redhatgov.io.conf
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Renewal configuration file /etc/letsencrypt/renewal/reg.koz.redhatgov.io.conf (cert: reg.koz.redhatgov.io) produced an unexpected error: 'Namespace' object has no attribute 'dns_route53_propagation_seconds'. Skipping.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Processing /etc/letsencrypt/renewal/triad.eadgbe.net.conf
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Cert is due for renewal, auto-renewing...
Could not choose appropriate plugin: The manual plugin is not working; there may be problems with your existing configuration.
The error was: PluginError('An authentication script must be provided with --manual-auth-hook when using the manual plugin non-interactively.',)
Attempting to renew cert (triad.eadgbe.net) from /etc/letsencrypt/renewal/triad.eadgbe.net.conf produced an unexpected error: The manual plugin is not working; there may be problems with your existing configuration.
The error was: PluginError('An authentication script must be provided with --manual-auth-hook when using the manual plugin non-interactively.',). Skipping.
All renewal attempts failed. The following certs could not be renewed:
  /etc/letsencrypt/live/triad.eadgbe.net/fullchain.pem (failure)

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
** DRY RUN: simulating 'certbot renew' close to cert expiry
**          (The test certificates below have not been saved.)

All renewal attempts failed. The following certs could not be renewed:
  /etc/letsencrypt/live/triad.eadgbe.net/fullchain.pem (failure)

Additionally, the following renewal configuration files were invalid: 
  /etc/letsencrypt/renewal/openshift.koz.redhatgov.io.conf (parsefail)
  /etc/letsencrypt/renewal/apps.koz.redhatgov.io.conf (parsefail)
  /etc/letsencrypt/renewal/apps.koz.redhatgov.io-0001.conf (parsefail)
  /etc/letsencrypt/renewal/reg.koz.redhatgov.io.conf (parsefail)
** DRY RUN: simulating 'certbot renew' close to cert expiry
**          (The test certificates above have not been saved.)
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
1 renew failure(s), 4 parse failure(s)
[root@triad ~]# docker run -it --rm --name certbot -v /etc/letsencrypt:/etc/letsencrypt docker.io/certbot/certbot renew --dry-run --manual
Saving debug log to /var/log/letsencrypt/letsencrypt.log

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Processing /etc/letsencrypt/renewal/openshift.koz.redhatgov.io.conf
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Renewal configuration file /etc/letsencrypt/renewal/openshift.koz.redhatgov.io.conf (cert: openshift.koz.redhatgov.io) produced an unexpected error: 'Namespace' object has no attribute 'dns_route53_propagation_seconds'. Skipping.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Processing /etc/letsencrypt/renewal/apps.koz.redhatgov.io.conf
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Renewal configuration file /etc/letsencrypt/renewal/apps.koz.redhatgov.io.conf (cert: apps.koz.redhatgov.io) produced an unexpected error: 'Namespace' object has no attribute 'dns_route53_propagation_seconds'. Skipping.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Processing /etc/letsencrypt/renewal/apps.koz.redhatgov.io-0001.conf
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Renewal configuration file /etc/letsencrypt/renewal/apps.koz.redhatgov.io-0001.conf (cert: apps.koz.redhatgov.io-0001) produced an unexpected error: 'Namespace' object has no attribute 'dns_route53_propagation_seconds'. Skipping.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Processing /etc/letsencrypt/renewal/reg.koz.redhatgov.io.conf
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Renewal configuration file /etc/letsencrypt/renewal/reg.koz.redhatgov.io.conf (cert: reg.koz.redhatgov.io) produced an unexpected error: 'Namespace' object has no attribute 'dns_route53_propagation_seconds'. Skipping.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Processing /etc/letsencrypt/renewal/triad.eadgbe.net.conf
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Cert is due for renewal, auto-renewing...
Could not choose appropriate plugin: The manual plugin is not working; there may be problems with your existing configuration.
The error was: PluginError('An authentication script must be provided with --manual-auth-hook when using the manual plugin non-interactively.',)
Attempting to renew cert (triad.eadgbe.net) from /etc/letsencrypt/renewal/triad.eadgbe.net.conf produced an unexpected error: The manual plugin is not working; there may be problems with your existing configuration.
The error was: PluginError('An authentication script must be provided with --manual-auth-hook when using the manual plugin non-interactively.',). Skipping.
All renewal attempts failed. The following certs could not be renewed:
  /etc/letsencrypt/live/triad.eadgbe.net/fullchain.pem (failure)

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
** DRY RUN: simulating 'certbot renew' close to cert expiry
**          (The test certificates below have not been saved.)

All renewal attempts failed. The following certs could not be renewed:
  /etc/letsencrypt/live/triad.eadgbe.net/fullchain.pem (failure)

Additionally, the following renewal configuration files were invalid: 
  /etc/letsencrypt/renewal/openshift.koz.redhatgov.io.conf (parsefail)
  /etc/letsencrypt/renewal/apps.koz.redhatgov.io.conf (parsefail)
  /etc/letsencrypt/renewal/apps.koz.redhatgov.io-0001.conf (parsefail)
  /etc/letsencrypt/renewal/reg.koz.redhatgov.io.conf (parsefail)
** DRY RUN: simulating 'certbot renew' close to cert expiry
**          (The test certificates above have not been saved.)
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
1 renew failure(s), 4 parse failure(s)
[root@triad ~]# docker run -it --rm --name certbot -v /etc/letsencrypt:/etc/letsencrypt docker.io/certbot/certbot renew --dry-run 
Saving debug log to /var/log/letsencrypt/letsencrypt.log

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Processing /etc/letsencrypt/renewal/openshift.koz.redhatgov.io.conf
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Renewal configuration file /etc/letsencrypt/renewal/openshift.koz.redhatgov.io.conf (cert: openshift.koz.redhatgov.io) produced an unexpected error: 'Namespace' object has no attribute 'dns_route53_propagation_seconds'. Skipping.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Processing /etc/letsencrypt/renewal/apps.koz.redhatgov.io.conf
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Renewal configuration file /etc/letsencrypt/renewal/apps.koz.redhatgov.io.conf (cert: apps.koz.redhatgov.io) produced an unexpected error: 'Namespace' object has no attribute 'dns_route53_propagation_seconds'. Skipping.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Processing /etc/letsencrypt/renewal/apps.koz.redhatgov.io-0001.conf
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Renewal configuration file /etc/letsencrypt/renewal/apps.koz.redhatgov.io-0001.conf (cert: apps.koz.redhatgov.io-0001) produced an unexpected error: 'Namespace' object has no attribute 'dns_route53_propagation_seconds'. Skipping.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Processing /etc/letsencrypt/renewal/reg.koz.redhatgov.io.conf
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Renewal configuration file /etc/letsencrypt/renewal/reg.koz.redhatgov.io.conf (cert: reg.koz.redhatgov.io) produced an unexpected error: 'Namespace' object has no attribute 'dns_route53_propagation_seconds'. Skipping.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Processing /etc/letsencrypt/renewal/triad.eadgbe.net.conf
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Cert is due for renewal, auto-renewing...
Could not choose appropriate plugin: The manual plugin is not working; there may be problems with your existing configuration.
The error was: PluginError('An authentication script must be provided with --manual-auth-hook when using the manual plugin non-interactively.',)
Attempting to renew cert (triad.eadgbe.net) from /etc/letsencrypt/renewal/triad.eadgbe.net.conf produced an unexpected error: The manual plugin is not working; there may be problems with your existing configuration.
The error was: PluginError('An authentication script must be provided with --manual-auth-hook when using the manual plugin non-interactively.',). Skipping.
All renewal attempts failed. The following certs could not be renewed:
  /etc/letsencrypt/live/triad.eadgbe.net/fullchain.pem (failure)

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
** DRY RUN: simulating 'certbot renew' close to cert expiry
**          (The test certificates below have not been saved.)

All renewal attempts failed. The following certs could not be renewed:
  /etc/letsencrypt/live/triad.eadgbe.net/fullchain.pem (failure)

Additionally, the following renewal configuration files were invalid: 
  /etc/letsencrypt/renewal/openshift.koz.redhatgov.io.conf (parsefail)
  /etc/letsencrypt/renewal/apps.koz.redhatgov.io.conf (parsefail)
  /etc/letsencrypt/renewal/apps.koz.redhatgov.io-0001.conf (parsefail)
  /etc/letsencrypt/renewal/reg.koz.redhatgov.io.conf (parsefail)
** DRY RUN: simulating 'certbot renew' close to cert expiry
**          (The test certificates above have not been saved.)
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
1 renew failure(s), 4 parse failure(s)
[root@triad ~]# docker run -it --rm --name certbot -v /etc/letsencrypt:/etc/letsencrypt docker.io/certbot/certbot bash
usage: 
  certbot [SUBCOMMAND] [options] [-d DOMAIN] [-d DOMAIN] ...

Certbot can obtain and install HTTPS/TLS/SSL certificates.  By default,
it will attempt to use a webserver both for obtaining and installing the
certificate. 
certbot: error: unrecognized arguments: bash
[root@triad ~]# docker run -it --rm --name certbot -d triad.eadgbe.net  docker.io/certbot/certbot renew
Unable to find image 'triad.eadgbe.net:latest' locally
Trying to pull repository registry.access.redhat.com/triad.eadgbe.net ... 
Trying to pull repository docker.io/library/triad.eadgbe.net ... 
Trying to pull repository registry.fedoraproject.org/triad.eadgbe.net ... 
Trying to pull repository quay.io/triad.eadgbe.net ... 
Trying to pull repository registry.access.redhat.com/triad.eadgbe.net ... 
Trying to pull repository registry.centos.org/triad.eadgbe.net ... 
Trying to pull repository docker.io/library/triad.eadgbe.net ... 
/usr/bin/docker-current: repository docker.io/triad.eadgbe.net not found: does not exist or no pull access.
See '/usr/bin/docker-current run --help'.
[root@triad ~]# docker run -it --rm --name certbot docker.io/certbot/certbot renew -d triad.eadgbe.net
Saving debug log to /var/log/letsencrypt/letsencrypt.log
Currently, the renew verb is capable of either renewing all installed certificates that are due to be renewed or renewing a single certificate specified by its name. If you would like to renew specific certificates by their domains, use the certonly command instead. The renew verb may provide other options for selecting certificates to renew in the future.
[root@triad ~]# docker run -it --rm --name certbot docker.io/certbot/certbot certonly -d triad.eadgbe.net
Saving debug log to /var/log/letsencrypt/letsencrypt.log

How would you like to authenticate with the ACME CA?
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
1: Spin up a temporary webserver (standalone)
2: Place files in webroot directory (webroot)
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Select the appropriate number [1-2] then [enter] (press 'c' to cancel): 2
Plugins selected: Authenticator webroot, Installer None
Enter email address (used for urgent renewal and security notices) (Enter 'c' to
cancel): bkozdemba@gmail.com

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Please read the Terms of Service at
https://letsencrypt.org/documents/LE-SA-v1.2-November-15-2017.pdf. You must
agree in order to register with the ACME server at
https://acme-v02.api.letsencrypt.org/directory
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
(A)gree/(C)ancel: A

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Would you be willing to share your email address with the Electronic Frontier
Foundation, a founding partner of the Let's Encrypt project and the non-profit
organization that develops Certbot? We'd like to send you email about our work
encrypting the web, EFF news, campaigns, and ways to support digital freedom.
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
(Y)es/(N)o: Y
Obtaining a new certificate
Performing the following challenges:
http-01 challenge for triad.eadgbe.net
Input the webroot for triad.eadgbe.net: (Enter 'c' to cancel): https://triad.eadgbe.net

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
https://triad.eadgbe.net does not exist or is not a directory
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Input the webroot for triad.eadgbe.net: (Enter 'c' to cancel): /var/www/html

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
/var/www/html does not exist or is not a directory
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Input the webroot for triad.eadgbe.net: (Enter 'c' to cancel): 

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 does not exist or is not a directory
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Input the webroot for triad.eadgbe.net: (Enter 'c' to cancel): triad.eadgbe.net

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
triad.eadgbe.net does not exist or is not a directory
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Input the webroot for triad.eadgbe.net: (Enter 'c' to cancel): http://triad.eadgbe.net

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
http://triad.eadgbe.net does not exist or is not a directory
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Input the webroot for triad.eadgbe.net: (Enter 'c' to cancel): c
Cleaning up challenges
Every requested domain must have a webroot when using the webroot plugin.

IMPORTANT NOTES:
 - Your account credentials have been saved in your Certbot
   configuration directory at /etc/letsencrypt. You should make a
   secure backup of this folder now. This configuration directory will
   also contain certificates and private keys obtained by Certbot so
   making regular backups of this folder is ideal.
[root@triad ~]# curl
curl: try 'curl --help' or 'curl --manual' for more information
[root@triad ~]# nslookup -q=TXT _acme-challenge.triad.eadgbe.net
Server:		127.0.0.1
Address:	127.0.0.1#53

** server can't find _acme-challenge.triad.eadgbe.net: NXDOMAIN

[root@triad ~]# ls
anaconda-ks.cfg  Documents            letsencrypt.sh   Pictures        run-mysql.sh   run-registry.sh         Videos
app_keys         Downloads            letsencrypt.txt  Public          run-nexus.sh   run-workshopper.sh
backup.sh        etc-letsencrypt.bak  Music            run-elastic.sh  run-ocp.sh     Templates
Desktop          grub2-theme-breeze   nexus-functions  run-gitlab.sh   run-piwigo.sh  v310-aws-gluster.hosts
[root@triad ~]# docker run -it --rm --name certbot -v /etc/letsencrypt:/etc/letsencrypt docker.io/certbot/certbot renew --dry-run --preferred-challenges tls-nsi
usage: 
  certbot [SUBCOMMAND] [options] [-d DOMAIN] [-d DOMAIN] ...

Certbot can obtain and install HTTPS/TLS/SSL certificates.  By default,
it will attempt to use a webserver both for obtaining and installing the
certificate. 
certbot: error: argument --preferred-challenges: Unrecognized challenges: tls-nsi
[root@triad ~]# docker run -it --rm --name certbot -v /etc/letsencrypt:/etc/letsencrypt docker.io/certbot/certbot renew --dry-run --preferred-challenges tls-sni
Saving debug log to /var/log/letsencrypt/letsencrypt.log

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Processing /etc/letsencrypt/renewal/openshift.koz.redhatgov.io.conf
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Renewal configuration file /etc/letsencrypt/renewal/openshift.koz.redhatgov.io.conf (cert: openshift.koz.redhatgov.io) produced an unexpected error: 'Namespace' object has no attribute 'dns_route53_propagation_seconds'. Skipping.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Processing /etc/letsencrypt/renewal/apps.koz.redhatgov.io.conf
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Renewal configuration file /etc/letsencrypt/renewal/apps.koz.redhatgov.io.conf (cert: apps.koz.redhatgov.io) produced an unexpected error: 'Namespace' object has no attribute 'dns_route53_propagation_seconds'. Skipping.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Processing /etc/letsencrypt/renewal/apps.koz.redhatgov.io-0001.conf
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Renewal configuration file /etc/letsencrypt/renewal/apps.koz.redhatgov.io-0001.conf (cert: apps.koz.redhatgov.io-0001) produced an unexpected error: 'Namespace' object has no attribute 'dns_route53_propagation_seconds'. Skipping.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Processing /etc/letsencrypt/renewal/reg.koz.redhatgov.io.conf
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Renewal configuration file /etc/letsencrypt/renewal/reg.koz.redhatgov.io.conf (cert: reg.koz.redhatgov.io) produced an unexpected error: 'Namespace' object has no attribute 'dns_route53_propagation_seconds'. Skipping.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Processing /etc/letsencrypt/renewal/triad.eadgbe.net.conf
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Cert is due for renewal, auto-renewing...
Could not choose appropriate plugin: The manual plugin is not working; there may be problems with your existing configuration.
The error was: PluginError('An authentication script must be provided with --manual-auth-hook when using the manual plugin non-interactively.',)
Attempting to renew cert (triad.eadgbe.net) from /etc/letsencrypt/renewal/triad.eadgbe.net.conf produced an unexpected error: The manual plugin is not working; there may be problems with your existing configuration.
The error was: PluginError('An authentication script must be provided with --manual-auth-hook when using the manual plugin non-interactively.',). Skipping.
All renewal attempts failed. The following certs could not be renewed:
  /etc/letsencrypt/live/triad.eadgbe.net/fullchain.pem (failure)

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
** DRY RUN: simulating 'certbot renew' close to cert expiry
**          (The test certificates below have not been saved.)

All renewal attempts failed. The following certs could not be renewed:
  /etc/letsencrypt/live/triad.eadgbe.net/fullchain.pem (failure)

Additionally, the following renewal configuration files were invalid: 
  /etc/letsencrypt/renewal/openshift.koz.redhatgov.io.conf (parsefail)
  /etc/letsencrypt/renewal/apps.koz.redhatgov.io.conf (parsefail)
  /etc/letsencrypt/renewal/apps.koz.redhatgov.io-0001.conf (parsefail)
  /etc/letsencrypt/renewal/reg.koz.redhatgov.io.conf (parsefail)
** DRY RUN: simulating 'certbot renew' close to cert expiry
**          (The test certificates above have not been saved.)
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
1 renew failure(s), 4 parse failure(s)
[root@triad ~]# docker run -it --rm --name certbot docker.io/certbot/certbot certonly --manual --preferred-challenges tls-sni --email bkozdemba@gmail.com -d triad.eadgbe.net --agree-tos --dry-run
Saving debug log to /var/log/letsencrypt/letsencrypt.log
Plugins selected: Authenticator manual, Installer None
Obtaining a new certificate
Performing the following challenges:
Client with the currently selected authenticator does not support any combination of challenges that will satisfy the CA.
Client with the currently selected authenticator does not support any combination of challenges that will satisfy the CA.

IMPORTANT NOTES:
 - Your account credentials have been saved in your Certbot
   configuration directory at /etc/letsencrypt. You should make a
   secure backup of this folder now. This configuration directory will
   also contain certificates and private keys obtained by Certbot so
   making regular backups of this folder is ideal.
[root@triad ~]# docker run -it --rm --name certbot docker.io/certbot/certbot certonly --manual --preferred-challenges http --email bkozdemba@gmail.com -d triad.eadgbe.net --agree-tos --dry-run
Saving debug log to /var/log/letsencrypt/letsencrypt.log
Plugins selected: Authenticator manual, Installer None
Obtaining a new certificate
Performing the following challenges:
http-01 challenge for triad.eadgbe.net

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
NOTE: The IP of this machine will be publicly logged as having requested this
certificate. If you're running certbot in manual mode on a machine that is not
your server, please ensure you're okay with that.

Are you OK with your IP being logged?
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
(Y)es/(N)o: Y

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Create a file containing just this data:

quD7odG_Qg1IkqxUEOen6Z4waIlWCd-jXICGp9E53hA.5_9R999GAhA_Et3ryIw_UNeDU86rApKCbDCS9U8gdnE

And make it available on your web server at this URL:

http://triad.eadgbe.net/.well-known/acme-challenge/quD7odG_Qg1IkqxUEOen6Z4waIlWCd-jXICGp9E53hA

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Press Enter to Continue
Waiting for verification...
Cleaning up challenges
Failed authorization procedure. triad.eadgbe.net (http-01): urn:ietf:params:acme:error:unauthorized :: The client lacks sufficient authorization :: Invalid response from http://triad.eadgbe.net/.well-known/acme-challenge/quD7odG_Qg1IkqxUEOen6Z4waIlWCd-jXICGp9E53hA: q%!(EXTRA string=<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">

<html xmlns="http://www.w3.or)

IMPORTANT NOTES:
 - The following errors were reported by the server:

   Domain: triad.eadgbe.net
   Type:   unauthorized
   Detail: Invalid response from
   http://triad.eadgbe.net/.well-known/acme-challenge/quD7odG_Qg1IkqxUEOen6Z4waIlWCd-jXICGp9E53hA:
   q%!(EXTRA string=<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN"
   "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">

   <html xmlns="http://www.w3.or)

   To fix these errors, please make sure that your domain name was
   entered correctly and the DNS A/AAAA record(s) for that domain
   contain(s) the right IP address.
 - Your account credentials have been saved in your Certbot
   configuration directory at /etc/letsencrypt. You should make a
   secure backup of this folder now. This configuration directory will
   also contain certificates and private keys obtained by Certbot so
   making regular backups of this folder is ideal.
[root@triad ~]# nslookup -q=TXT _acme-challenge.triad.eadgbe.net
Server:		127.0.0.1
Address:	127.0.0.1#53

** server can't find _acme-challenge.triad.eadgbe.net: NXDOMAIN

[root@triad ~]# dnf search certbot
Last metadata expiration check: 2:47:30 ago on Sun 23 Sep 2018 07:21:42 AM CDT.
====================================================== Name Exactly Matched: certbot =======================================================
certbot.noarch : A free, automated certificate authority client
===================================================== Summary & Name Matched: certbot ======================================================
python2-certbot.noarch : Python 2 libraries used by certbot
python2-certbot-nginx.noarch : The nginx plugin for certbot
python3-certbot.noarch : Python 3 libraries used by certbot
python3-certbot-nginx.noarch : The nginx plugin for certbot
python2-certbot-apache.noarch : The apache plugin for certbot
python3-certbot-apache.noarch : The apache plugin for certbot
python-certbot-dns-nsone-doc.noarch : certbot-dns-nsone documentation
python-certbot-dns-luadns-doc.noarch : certbot-dns-luadns documentation
python2-certbot-dns-ovh.noarch : OVH DNS Authenticator plugin for Certbot
python3-certbot-dns-ovh.noarch : OVH DNS Authenticator plugin for Certbot
python-certbot-dns-cloudxns-doc.noarch : certbot-dns-cloudxns documentation
python-certbot-dns-dnsimple-doc.noarch : certbot-dns-dnsimple documentation
python2-certbot-dns-luadns.noarch : LuaDNS Authenticator plugin for Certbot
python2-certbot-dns-nsone.noarch : NS1 DNS Authenticator plugin for Certbot
python3-certbot-dns-luadns.noarch : LuaDNS Authenticator plugin for Certbot
python3-certbot-dns-nsone.noarch : NS1 DNS Authenticator plugin for Certbot
python-certbot-dns-ovh-doc.noarch : Documentation for python-certbot-dns-ovh
python-certbot-dns-cloudflare-doc.noarch : certbot-dns-cloudflare documentation
python2-certbot-dns-linode.noarch : Linode DNS Authenticator plugin for Certbot
python3-certbot-dns-linode.noarch : Linode DNS Authenticator plugin for Certbot
python-certbot-dns-dnsmadeeasy-doc.noarch : certbot-dns-dnsmadeeasy documentation
python2-certbot-dns-route53.noarch : Route53 DNS Authenticator plugin for Certbot
python3-certbot-dns-route53.noarch : Route53 DNS Authenticator plugin for Certbot
python-certbot-dns-gehirn-doc.noarch : Documentation for python-certbot-dns-gehirn
python-certbot-dns-linode-doc.noarch : Documentation for python-certbot-dns-linode
python2-certbot-dns-rfc2136.noarch : RFC 2136 DNS Authenticator plugin for Certbot
python3-certbot-dns-rfc2136.noarch : RFC 2136 DNS Authenticator plugin for Certbot
python2-certbot-dns-cloudxns.noarch : CloudXNS DNS Authenticator plugin for Certbot
python2-certbot-dns-dnsimple.noarch : DNSimple DNS Authenticator plugin for Certbot
python3-certbot-dns-cloudxns.noarch : CloudXNS DNS Authenticator plugin for Certbot
python3-certbot-dns-dnsimple.noarch : DNSimple DNS Authenticator plugin for Certbot
python2-certbot-dns-google.noarch : Google Cloud DNS Authenticator plugin for Certbot
python3-certbot-dns-google.noarch : Google Cloud DNS Authenticator plugin for Certbot
python2-certbot-dns-cloudflare.noarch : Cloudflare DNS Authenticator plugin for Certbot
python3-certbot-dns-cloudflare.noarch : Cloudflare DNS Authenticator plugin for Certbot
python2-certbot-dns-sakuracloud.noarch : Sakura Cloud DNS Authenticator plugin for Certbot
python3-certbot-dns-sakuracloud.noarch : Sakura Cloud DNS Authenticator plugin for Certbot
python2-certbot-dns-digitalocean.noarch : DigitalOcean DNS Authenticator plugin for Certbot
python2-certbot-dns-dnsmadeeasy.noarch : DNS Made Easy DNS Authenticator plugin for Certbot
python3-certbot-dns-digitalocean.noarch : DigitalOcean DNS Authenticator plugin for Certbot
python3-certbot-dns-dnsmadeeasy.noarch : DNS Made Easy DNS Authenticator plugin for Certbot
python-certbot-dns-sakuracloud-doc.noarch : Documentation for python-certbot-dns-sakuracloud
python2-certbot-dns-gehirn.noarch : Gehirn Infrastructure Service DNS Authenticator plugin for Certbot
python3-certbot-dns-gehirn.noarch : Gehirn Infrastructure Service DNS Authenticator plugin for Certbot
[root@triad ~]# nslookup -q=TXT _acme-challenge.triad.eadgbe.net
Server:		127.0.0.1
Address:	127.0.0.1#53

** server can't find _acme-challenge.triad.eadgbe.net: NXDOMAIN

[root@triad ~]# nslookup -q=TXT _acme-challenge.triad.eadgbe.net
Server:		127.0.0.1
Address:	127.0.0.1#53

** server can't find _acme-challenge.triad.eadgbe.net: NXDOMAIN

[root@triad ~]# docker run -it --rm --name certbot docker.io/certbot/certbot certonly --manual --preferred-challenges http --email bkozdemba@gmail.com -d presto.eadgbe.net --agree-tos --dry-run
^[[D^[[DSaving debug log to /var/log/letsencrypt/letsencrypt.log
Plugins selected: Authenticator manual, Installer None
^[[D^[[DObtaining a new certificate
Performing the following challenges:
http-01 challenge for presto.eadgbe.net

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
NOTE: The IP of this machine will be publicly logged as having requested this
certificate. If you're running certbot in manual mode on a machine that is not
your server, please ensure you're okay with that.

Are you OK with your IP being logged?
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
(Y)es/(N)o: 
(Y)es/(N)o: ç^CCleaning up challenges
Exiting abnormally:
Traceback (most recent call last):
  File "/usr/local/bin/certbot", line 11, in <module>
    load_entry_point('certbot', 'console_scripts', 'certbot')()
  File "/opt/certbot/src/certbot/main.py", line 1364, in main
    return config.func(config, plugins)
  File "/opt/certbot/src/certbot/main.py", line 1254, in certonly
    lineage = _get_and_save_cert(le_client, config, domains, certname, lineage)
  File "/opt/certbot/src/certbot/main.py", line 120, in _get_and_save_cert
    lineage = le_client.obtain_and_enroll_certificate(domains, certname)
  File "/opt/certbot/src/certbot/client.py", line 391, in obtain_and_enroll_certificate
    cert, chain, key, _ = self.obtain_certificate(domains)
  File "/opt/certbot/src/certbot/client.py", line 334, in obtain_certificate
    orderr = self._get_order_and_authorizations(csr.data, self.config.allow_subset_of_names)
  File "/opt/certbot/src/certbot/client.py", line 370, in _get_order_and_authorizations
    authzr = self.auth_handler.handle_authorizations(orderr, best_effort)
  File "/opt/certbot/src/certbot/auth_handler.py", line 75, in handle_authorizations
    resp = self._solve_challenges(aauthzrs)
  File "/opt/certbot/src/certbot/auth_handler.py", line 126, in _solve_challenges
    resp = self.auth.perform(all_achalls)
  File "/opt/certbot/src/certbot/plugins/manual.py", line 143, in perform
    self._verify_ip_logging_ok()
  File "/opt/certbot/src/certbot/plugins/manual.py", line 170, in _verify_ip_logging_ok
    if display.yesno(msg, cli_flag=cli_flag, force_interactive=True):
  File "/opt/certbot/src/certbot/display/util.py", line 223, in yesno
    no=_parens_around_char(no_label)))
  File "/opt/certbot/src/certbot/display/util.py", line 83, in input_with_timeout
    rlist, _, _ = select.select([sys.stdin], [], [], timeout)
KeyboardInterrupt
Please see the logfiles in /var/log/letsencrypt for more details.

IMPORTANT NOTES:
 - Your account credentials have been saved in your Certbot
   configuration directory at /etc/letsencrypt. You should make a
   secure backup of this folder now. This configuration directory will
   also contain certificates and private keys obtained by Certbot so
   making regular backups of this folder is ideal.
[root@triad ~]# docker run -it --rm --name certbot docker.io/certbot/certbot certonly --manual --preferred-challenges tls-nsi-01 --email bkozdemba@gmail.com -d triad.eadgbe.net --agree-tos --dry-run
usage: 
  certbot [SUBCOMMAND] [options] [-d DOMAIN] [-d DOMAIN] ...

Certbot can obtain and install HTTPS/TLS/SSL certificates.  By default,
it will attempt to use a webserver both for obtaining and installing the
certificate. 
certbot: error: argument --preferred-challenges: Unrecognized challenges: tls-nsi-01
[root@triad ~]# docker run -it --rm --name certbot docker.io/certbot/certbot certonly --manual --preferred-challenges tls-sni-01 --email bkozdemba@gmail.com -d triad.eadgbe.net --agree-tos --dry-run
Saving debug log to /var/log/letsencrypt/letsencrypt.log
Plugins selected: Authenticator manual, Installer None
Obtaining a new certificate
Performing the following challenges:
Client with the currently selected authenticator does not support any combination of challenges that will satisfy the CA.
Client with the currently selected authenticator does not support any combination of challenges that will satisfy the CA.

IMPORTANT NOTES:
 - Your account credentials have been saved in your Certbot
   configuration directory at /etc/letsencrypt. You should make a
   secure backup of this folder now. This configuration directory will
   also contain certificates and private keys obtained by Certbot so
   making regular backups of this folder is ideal.
[root@triad ~]# nslookup -q=TXT _acme-challenge.triad.eadgbe.net
Server:		127.0.0.1
Address:	127.0.0.1#53

** server can't find _acme-challenge.triad.eadgbe.net: NXDOMAIN

[root@triad ~]# logout
[bkozdemb@triad triad.eadgbe.net]$ ls
triad-eadgbe.net.csr  triad-eadgbe.net-key.pem
[bkozdemb@triad triad.eadgbe.net]$ vim triad-eadgbe.net.csr 
[bkozdemb@triad triad.eadgbe.net]$ ls
triad-eadgbe.net.csr  triad-eadgbe.net.csr~  triad-eadgbe.net-key.pem
[bkozdemb@triad triad.eadgbe.net]$ vim triad-eadgbe.net-key.pem 
[bkozdemb@triad triad.eadgbe.net]$ ls
triad-eadgbe.net.csr  triad-eadgbe.net.csr~  triad-eadgbe.net-key.pem  triad-eadgbe.net-key.pem~
[bkozdemb@triad triad.eadgbe.net]$ vim triad-eadgbe.net.crt
[bkozdemb@triad triad.eadgbe.net]$ ls
triad-eadgbe.net.crt  triad-eadgbe.net.csr  triad-eadgbe.net.csr~  triad-eadgbe.net-key.pem  triad-eadgbe.net-key.pem~
[bkozdemb@triad triad.eadgbe.net]$ ls -l
total 24
-rw-rw-r--. 1 bkozdemb bkozdemb 4153 Sep 23 10:33 triad-eadgbe.net.crt
-rw-rw-r--. 1 bkozdemb bkozdemb 1656 Sep 23 10:22 triad-eadgbe.net.csr
-rw-rw-r--. 1 bkozdemb bkozdemb 1656 Sep 23 09:41 triad-eadgbe.net.csr~
-rw-rw-r--. 1 bkozdemb bkozdemb 3244 Sep 23 10:23 triad-eadgbe.net-key.pem
-rw-rw-r--. 1 bkozdemb bkozdemb 3244 Sep 23 09:42 triad-eadgbe.net-key.pem~
[bkozdemb@triad triad.eadgbe.net]$ vim triad-eadgbe.net-key.pem
[bkozdemb@triad triad.eadgbe.net]$ ls
triad-eadgbe.net.crt  triad-eadgbe.net.csr  triad-eadgbe.net.csr~  triad-eadgbe.net-key.pem  triad-eadgbe.net-key.pem~
[bkozdemb@triad triad.eadgbe.net]$ sudo cp triad-eadgbe.net.crt /etc/pki/tls/certs/triad.eadgbe.net.crt 
[bkozdemb@triad triad.eadgbe.net]$ sudo cp triad-eadgbe.net-key.pem /etc/pki/tls/private/triad.eadgbe.net-key.crt
[bkozdemb@triad triad.eadgbe.net]$ logout
Connection to triad.eadgbe.net closed.
allegro:~ koz$ ssh triad
Last login: Sun Sep 23 12:04:57 2018 from 72.177.93.176
[bkozdemb@triad ~]$ sudo -i
[root@triad ~]# cd /etc/httpd/conf.d/
[root@triad conf.d]# ls
autoindex.conf  mod_dnssd.conf  README  ssl.conf  userdir.conf  welcome.conf
[root@triad conf.d]# cp ssl.conf ssl.conf.orig
[root@triad conf.d]# vim ssl.conf
[root@triad conf.d]# cd
[root@triad ~]# ls
anaconda-ks.cfg  Documents            letsencrypt.sh   Pictures        run-mysql.sh   run-registry.sh         Videos
app_keys         Downloads            letsencrypt.txt  Public          run-nexus.sh   run-workshopper.sh
backup.sh        etc-letsencrypt.bak  Music            run-elastic.sh  run-ocp.sh     Templates
Desktop          grub2-theme-breeze   nexus-functions  run-gitlab.sh   run-piwigo.sh  v310-aws-gluster.hosts
[root@triad ~]# cat letsencrypt.sh 
#!/bin/bash
#
# Based on Jared's certbot role.
# https://raw.githubusercontent.com/jaredhocutt/openshift-provision/master/playbooks/roles/install_openshift/tasks/certs.yml
#

openshift_public_hostname="openshift.koz.redhat.gov.io"
openshift_subdomain="*.apps.koz.redhatgov.io"
cert_email_address="bkozdemba@gmail.com"
reg_public_hostname="reg.koz.redhatgov.io"

mkdir /etc/letsencrypt
chmod -R 555 /etc/letsencrypt
chown -R ec2-user:ec2-user /etc/letsencrypt

echo "Variables"
echo "AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID"
echo "AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY"
echo "cert_email_address=$cert_email_address"
echo "openshift_public_hostname=$openshift_public_hostname"
echo "openshift_subdomain=$openshift_subdomain"
echo "reg_public_hostname=$reg_public_hostname"

#path: "/etc/letsencrypt"
#    entity: "{{ ansible_user }}"
#    etype: user
#    permissions: rx
#    recursive: yes
#    follow: yes
#    state: present


echo "Genrating cert for OCP api"

docker run --rm --name certbot \
    -v "/etc/letsencrypt:/etc/letsencrypt:z" \
    -v "/var/lib/letsencrypt:/var/lib/letsencrypt:z" \
    -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
    -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
    certbot/dns-route53 certonly \
    --non-interactive \
    --agree-tos \
    --email $cert_email_address \
    --dns-route53 \
    --dns-route53-propagation-seconds 30 \
    --domain $openshift_public_hostname

# creates: /etc/letsencrypt/live/{{ openshift_public_hostname }}

echo "Genrating wildcard cert for OCP router"

docker run --rm --name certbot \
    -v "/etc/letsencrypt:/etc/letsencrypt:z" \
    -v "/var/lib/letsencrypt:/var/lib/letsencrypt:z" \
    -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
    -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
    certbot/dns-route53 certonly \
    --non-interactive \
    --agree-tos \
    --email $cert_email_address \
    --dns-route53 \
    --dns-route53-propagation-seconds 30 \
    --server https://acme-v02.api.letsencrypt.org/directory \
    --domain "$openshift_subdomain" 

#    creates: /etc/letsencrypt/live/apps.{{ openshift_public_hostname }}

echo "Genrating cert for $reg_public_hostname"

docker run --rm --name certbot \
    -v "/etc/letsencrypt:/etc/letsencrypt:z" \
    -v "/var/lib/letsencrypt:/var/lib/letsencrypt:z" \
    -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
    -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
    certbot/dns-route53 certonly \
    --non-interactive \
    --agree-tos \
    --email $cert_email_address \
    --dns-route53 \
    --dns-route53-propagation-seconds 30 \
    --domain $reg_public_hostname
[root@triad ~]# ls
anaconda-ks.cfg  Documents            letsencrypt.sh   Pictures        run-mysql.sh   run-registry.sh         Videos
app_keys         Downloads            letsencrypt.txt  Public          run-nexus.sh   run-workshopper.sh
backup.sh        etc-letsencrypt.bak  Music            run-elastic.sh  run-ocp.sh     Templates
Desktop          grub2-theme-breeze   nexus-functions  run-gitlab.sh   run-piwigo.sh  v310-aws-gluster.hosts
[root@triad ~]# vim gen-install-certs.sh
[root@triad ~]# cat gen-install-certs.sh 
#!/bin/bash

certbot --apache -d triad.eadgbe.net

cp /etc/letsencrypt/live/triad.eadgbe.net/fullchain.pem /etc/pki/tls/certs/triad.eadgbe.net.crt
cp /etc/letsencrypt/live/triad.eadgbe.net/privkey.pem /etc/pki/tls/private/triad.eadgbe.net-key.crt

systemctl restart httpd

# IMPORTANT NOTES:
#  - Congratulations! Your certificate and chain have been saved at:
#    /etc/letsencrypt/live/triad.eadgbe.net/fullchain.pem
#    Your key file has been saved at:
#    /etc/letsencrypt/live/triad.eadgbe.net/privkey.pem
#    Your cert will expire on 2018-12-22. To obtain a new or tweaked
#    version of this certificate in the future, simply run certbot again
#    with the "certonly" option. To non-interactively renew *all* of
#    your certificates, run "certbot renew"

# SSLCertificateFile /etc/pki/tls/certs/triad.eadgbe.net.crt

#   Server Private Key:
#   If the key is not combined with the certificate, use this
#   directive to point at the key file.  Keep in mind that if
#   you've both a RSA and a DSA private key you can configure
#   both in parallel (to also allow the use of DSA ciphers, etc.)
#   ECC keys, when in use, can also be configured in parallel
# SSLCertificateKeyFile /etc/pki/tls/private/localhost.key
# SSLCertificateKeyFile /etc/pki/tls/private/triad.eadgbe.net-key.crt


[root@triad ~]# docker run -it --rm --name certbot docker.io/certbot/certbot certonly --manual --preferred-challenges tls-nsi-01 --email bkozdemba@gmail.com -d triad.eadgbe.net --agree-tos --dry-run^C
[root@triad ~]# certbot renew
Saving debug log to /var/log/letsencrypt/letsencrypt.log

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Processing /etc/letsencrypt/renewal/triad.eadgbe.net.conf
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Cert not yet due for renewal

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

The following certs are not due for renewal yet:
  /etc/letsencrypt/live/triad.eadgbe.net/fullchain.pem expires on 2018-12-22 (skipped)
No renewals were attempted.
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
[root@triad ~]# ls /etc/letsencrypt/renewal/triad.eadgbe.net.conf 
/etc/letsencrypt/renewal/triad.eadgbe.net.conf
[root@triad ~]# cat /etc/letsencrypt/renewal/triad.eadgbe.net.conf 
# renew_before_expiry = 30 days
version = 0.27.1
archive_dir = /etc/letsencrypt/archive/triad.eadgbe.net
cert = /etc/letsencrypt/live/triad.eadgbe.net/cert.pem
privkey = /etc/letsencrypt/live/triad.eadgbe.net/privkey.pem
chain = /etc/letsencrypt/live/triad.eadgbe.net/chain.pem
fullchain = /etc/letsencrypt/live/triad.eadgbe.net/fullchain.pem

# Options used in the renewal process
[renewalparams]
account = 5d11614434bafe5df370f0d8b12839f9
authenticator = apache
installer = apache
server = https://acme-v02.api.letsencrypt.org/directory
[root@triad ~]# certbot renewç^C
[root@triad ~]# 
[root@triad ~]# 
[root@triad ~]# ls
anaconda-ks.cfg  Documents             grub2-theme-breeze  nexus-functions  run-gitlab.sh  run-piwigo.sh       v310-aws-gluster.hosts
app_keys         Downloads             letsencrypt.sh      Pictures         run-mysql.sh   run-registry.sh     Videos
backup.sh        etc-letsencrypt.bak   letsencrypt.txt     Public           run-nexus.sh   run-workshopper.sh
Desktop          gen-install-certs.sh  Music               run-elastic.sh   run-ocp.sh     Templates
[root@triad ~]# vim gen-install-certs.sh 
[root@triad ~]# cat gen-install-certs.sh
#!/bin/bash

certbot --apache -d triad.eadgbe.net

cp /etc/letsencrypt/live/triad.eadgbe.net/fullchain.pem /etc/pki/tls/certs/triad.eadgbe.net.crt
cp /etc/letsencrypt/live/triad.eadgbe.net/privkey.pem /etc/pki/tls/private/triad.eadgbe.net-key.crt

systemctl restart httpd

certbot renew

# IMPORTANT NOTES:
#  - Congratulations! Your certificate and chain have been saved at:
#    /etc/letsencrypt/live/triad.eadgbe.net/fullchain.pem
#    Your key file has been saved at:
#    /etc/letsencrypt/live/triad.eadgbe.net/privkey.pem
#    Your cert will expire on 2018-12-22. To obtain a new or tweaked
#    version of this certificate in the future, simply run certbot again
#    with the "certonly" option. To non-interactively renew *all* of
#    your certificates, run "certbot renew"

# SSLCertificateFile /etc/pki/tls/certs/triad.eadgbe.net.crt

#   Server Private Key:
#   If the key is not combined with the certificate, use this
#   directive to point at the key file.  Keep in mind that if
#   you've both a RSA and a DSA private key you can configure
#   both in parallel (to also allow the use of DSA ciphers, etc.)
#   ECC keys, when in use, can also be configured in parallel
# SSLCertificateKeyFile /etc/pki/tls/private/localhost.key
# SSLCertificateKeyFile /etc/pki/tls/private/triad.eadgbe.net-key.crt


[root@triad ~]# cp /etc/letsencrypt/live/triad.eadgbe.net/fullchain.pem /etc/pki/tls/certs/triad.eadgbe.net.crt
cp: overwrite '/etc/pki/tls/certs/triad.eadgbe.net.crt'? 
[root@triad ~]# systemctl restart httpd
[root@triad ~]# ls /etc/pki/tls/cert
ls: cannot access '/etc/pki/tls/cert': No such file or directory
[root@triad ~]# ls /etc/pki/tls/certs/
2015-RH-IT-Root-CA.pem  ca-bundle.crt  ca-bundle.trust.crt  newca.crt  oracle_ebs.crt  triad.eadgbe.net.crt
[root@triad ~]# ls -l /etc/pki/tls/certs/triad.eadgbe.net.crt 
-rw-r--r--. 1 root root 4153 Sep 23 10:37 /etc/pki/tls/certs/triad.eadgbe.net.crt
[root@triad ~]# date
Sun Sep 23 12:48:40 CDT 2018
[root@triad ~]# cp /etc/letsencrypt/live/triad.eadgbe.net/fullchain.pem /etc/pki/tls/certs/triad.eadgbe.net.crt
cp: overwrite '/etc/pki/tls/certs/triad.eadgbe.net.crt'? y
[root@triad ~]# cp /etc/letsencrypt/live/triad.eadgbe.net/privkey.pem /etc/pki/tls/private/triad.eadgbe.net-key.crt
cp: overwrite '/etc/pki/tls/private/triad.eadgbe.net-key.crt'? 
[root@triad ~]# cp /etc/letsencrypt/live/triad.eadgbe.net/privkey.pem /etc/pki/tls/private/triad.eadgbe.net-key.crt
cp: overwrite '/etc/pki/tls/private/triad.eadgbe.net-key.crt'? y
[root@triad ~]# cp /etc/letsencrypt/live/triad.eadgbe.net/fullchain.pem /etc/pki/tls/certs/triad.eadgbe.net.crt
cp: overwrite '/etc/pki/tls/certs/triad.eadgbe.net.crt'? y
[root@triad ~]# systemctl restart httpd
[root@triad ~]# history
   28  systemctl restart docker
   29  docker images
   30  docker pull openshift/hello-openshift
   31  docker login presto.eadgbe.net:8443 -u demo -p 0pen\$hiftr0x
   32  docker images
   33  docker tag docker.io/openshift/hello-openshift presto.eadgbe.net:8443/hello-openshift
   34  docker images
   35  docker push presto.eadgbe.net:8443/hello-openshift
   36  docker pull registry.access.redhat.com/rhel-atomic
   37  docker tag registry.access.redhat.com/rhel-atomic presto.eadgbe.net:8443/rhel-atomic
   38  docker tag  presto.eadgbe.net:8443/rhel-atomic
   39  docker push  presto.eadgbe.net:8443/rhel-atomic
   40  docker
   41  skopeo --help
   42  skopeo inspect docker://presto.eadgbe.net/hello-openshift
   43  skopeo inspect docker://presto.eadgbe.net:8443/hello-openshift
   44  ls
   45  ls /registry/certs
   46  ls
   47  vim run-elastic.sh 
   48  docker ps
   49  sh ./run-elastic.sh 
   50  ls -R /pv/elk/elasticsearch/
   51  docker ps
   52  docker logs elasticsearch
   53  ls -R /pv/elk/elasticsearch/
   54  docker exec -it elasticsearch bash
   55  ls
   56  exit
   57  docker exec -it elasticsearch bash
   58  vim run-elastic.sh 
   59  sh ./run-elastic.sh 
   60  docker logs elasticsearch
   61  vim run-elastic.sh 
   62  docker logs elasticsearch
   63  cat run-elastic.sh 
   64  TAG=6.3.1
   65  docker rm -f elasticsearch kibana
   66  docker run --name=elasticsearch -it -p 9200:9200 -v /pv/elk/elasticsearch:/usr/share/elasticsearch docker.elastic.co/elasticsearch/elasticsearch:$TAG
   67  ls /pv/elk/elasticsearch/
   68  docker run --name=elasticsearch -it -p 9200:9200  docker.elastic.co/elasticsearch/elasticsearch:$TAG
   69  docker rm -f elasticsearch; docker run --name=elasticsearch -it -p 9200:9200  docker.elastic.co/elasticsearch/elasticsearch:$TAG
   70  docker rm -f elasticsearch; docker run --name=elasticsearch -d -p 9200:9200  docker.elastic.co/elasticsearch/elasticsearch:$TAG
   71  docker logs elasticsearch 
   72  docker logs elasticsearch --follow
   73  ls -l /pv
   74  ls -l /pv/elk/
   75  ls -Z /pv/elk/
   76  docker rm -f elasticsearch; docker run --name=elasticsearch -d -p 9200:9200 -v/pv/elk/elasticsearch:/usr/share/elasticsearch docker.elastic.co/elasticsearch/elasticsearch:$TAG
   77  docker logs elasticsearch --follow
   78  docker ps
   79  docker rm -f elasticsearch; docker run --name=elasticsearch -d -p 9200:9200  docker.elastic.co/elasticsearch/elasticsearch:$TAG
   80  docker exec -it elasticsearch bash
   81  docker rm -f elasticsearch; docker run --name=elasticsearch -d -p 9200:9200 -v /pv/elk/elasticsearch:/usr/share/elasticsearch/data docker.elastic.co/elasticsearch/elasticsearch:$TAG
   82  docker logs elasticsearch --follow
   83  ls -R /pv/elk/
   84  vim run-elastic.sh 
   85  sh ./run-elastic.sh 
   86  docker ps
   87  exit
   88  docker exec -it elasticsearch bash
   89  ls
   90  sh ./run-elastic.sh 
   91  docker logs elasticsearch --follow
   92  ls
   93  cat run-elastic.sh 
   94  cat /home/bkozdemb/.aws/credentials 
   95  export AWS_ACCESS_KEY_ID=AKIAIX2WNBSONBNZHZ5A
   96  export AWS_SECRET_ACCESS_KEY=rPE3siPYW12bfeWPDAPv3sQzH9f6d67l4hi0Fbl
   97  ls
   98  sh ./letsencrypt.sh 
   99  ls /etc/letsencrypt/
  100  cp -a /etc/letsencrypt letsencrypt-etc-.bak
  101  sh ./letsencrypt.sh 
  102  host apps.openshift.koz.redhatgov.io
  103  host test.apps.openshift.koz.redhatgov.io
  104  host test.apps.koz.redhatgov.io
  105  host openshift.koz.redhatgov.io
  106  sh ./letsencrypt.sh 
  107  env|grep AWS
  108  cat /home/bkozdemb/.aws/credentials 
  109  AWS_SECRET_ACCESS_KEY=M9j6kCQvghXw0zlOUvGr/7mWfwMtkOiyFV5Rwgmi
  110  env|grep AWS
  111  sh ./letsencrypt.sh 
  112  vim letsencrypt.txt
  113  cd /etc/letsencrypt/live/
  114  ls
  115  cd openshift.koz.redhatgov.io/
  116  ls
  117  file *
  118  cd ../../archive/openshift.koz.redhatgov.io/
  119  file *
  120  openssl x509 -in cert1.pem -noout
  121  openssl x509 -in cert1.pem -text
  122  openssl x509 -in cert1.pem -text|more
  123  ls
  124  openssl x509 -in chain1.pem -text|more
  125  ls
  126  openssl x509 -in fullchain1.pem -text|more
  127  openssl x509 -in chain1.pem -text|more
  128  cd
  129  ls
  130  sh ./letsencrypt.sh 
  131  ls /etc/letsencrypt/live/
  132  cd /etc/letsencrypt/live/
  133  ls
  134  cd openshift.koz.redhatgov.io/
  135  ls
  136  openssl verify cert.pem 
  137  openssl verify chain.pem 
  138  openssl verify fullchain.pem 
  139  less README 
  140  cat README 
  141  docker exec -it elasticsearch bash
  142  ls
  143  cat run-elastic.sh 
  144  ls /pv/elk/elasticsearch/
  145  ls /pv/elk/elasticsearch/nodes/
  146  ls /pv/elk/elasticsearch/nodes/0/
  147  ls /pv/elk/elasticsearch/nodes/0/indices/
  148  docker stop elasticsearch kibana
  149  vim run-elastic.sh
  150  sh run-elastic.sh
  151  docker logs elasticsearch --follow
  152  vim run-elastic.sh
  153  docker ps
  154  free -h
  155  docker exec -it elasticsearch bash
  156  ls
  157  vim letsencrypt.sh
  158  ls
  159  at run-registry.sh 
  160  run run-registry.sh 
  161  sh run-registry.sh 
  162  docker rm -f registry
  163  cat run-registry.sh 
  164  ls
  165  vim letsencrypt.sh
  166  sh letsencrypt.sh
  167  history|grep AWS
  168  export AWS_ACCESS_KEY_ID=AKIAIX2WNBSONBNZHZ5A
  169  export AWS_SECRET_ACCESS_KEY=rPE3siPYW12bfeWPDAPv3sQzH9f6d67l4hi0Fbl
  170  sh letsencrypt.sh
  171  history
  172  cat /home/bkozdemb/.aws/credentials 
  173  export AWS_SECRET_ACCESS_KEY=M9j6kCQvghXw0zlOUvGr/7mWfwMtkOiyFV5Rwgmi
  174  sh ./letsencrypt.sh
  175  openssl verify /etc/letsencrypt/live/reg.koz.redhatgov.io/fullchain.pem
  176  openssl crl2pkcs7 -nocrl -certfile cert.pem | openssl pkcs7 -print_certs -noout
  177  openssl crl2pkcs7 -nocrl -certfile /etc/letsencrypt/live/reg.koz.redhatgov.io/fullchain.pem | openssl pkcs7 -print_certs -noout
  178  mkdir /usr/tmp/certs
  179  cp /etc/letsencrypt/live/reg.koz.redhatgov.io/fullchain.pem /usr/tmp/certs/reg.koz.redhatgov.io.crt
  180  ls -l /usr/tmp
  181  ls -l /usr/tmp/
  182  ls -l /usr/tmp/certs/
  183  docker login reg.koz.redhatgov.io
  184  docker login reg.koz.redhatgov.io -u demo -p 0pen\$hiftr0x
  185  docker login reg.koz.redhatgov.io:443 -u demo -p 0pen\$hiftr0x
  186  docker login reg.koz.redhatgov.io -u demo -p 0pen\$hiftr0x
  187  docker images
  188  docker tag docker.io/openshift/hello-openshift reg.koz.redhatgov.io/hello-openshift
  189  docker push reg.koz.redhatgov.io/hello-openshift
  190  curl reg.koz.redhatgov.io -u demo -p 0pen\$hiftr0x
  191  curl https://reg.koz.redhatgov.io -u demo -p 0pen\$hiftr0x
  192  curl https://reg.koz.redhatgov.io -u demo
  193  curl https://reg.koz.redhatgov.io/v2/ -u demo
  194  curl https://demo:0pen\$hiftr0x@reg.koz.redhatgov.io/v2/ 
  195  curl https://demo:0pen\$hiftr0x@reg.koz.redhatgov.io/v2/repositories/
  196  curl https://demo:0pen\$hiftr0x@reg.koz.redhatgov.io/v2/_catalog
  197  curl https://demo:0pen\$hiftr0x@reg.koz.redhatgov.io/v2/_
  198  curl https://demo:0pen\$hiftr0x@reg.koz.redhatgov.io/v2/_*
  199  curl https://demo:0pen\$hiftr0x@reg.koz.redhatgov.io/v2/_catalog
  200  ls
  201  cat letsencrypt.sh 
  202  docker ps
  203  docker ps -a
  204  docker run --rm --name certbot --it certbot certbot-auto --help
  205  docker run -it --rm --name certbot certbot certbot-auto --help
  206  docker run -it --rm --name certbot docker.io/certbot/certbot certbot-auto --help
  207  docker run -it --rm --name certbot docker.io/certbot/certbot certbot-auto --dry-run
  208  docker run -it --rm --name certbot docker.io/certbot/certbot --dry-run
  209  docker run -it --rm --name certbot docker.io/certbot/certbot certonly --dry-run
  210  ls /etc/letsencrypt/
  211  ls /etc/letsencrypt/live/
  212  docker run -it --rm --name certbot docker.io/certbot/certbot certonly --dry-run
  213  docker run -it --rm --name certbot docker.io/certbot/certbot-auto --dry-run
  214  docker run -it --rm --name certbot docker.io/certbot/certbot certonly --email bkozdemba@gmail.com -d eadgbe.net --standalone --dry-run
  215  curl http://presto.eadgbe.net
  216  docker run -it --rm --name certbot docker.io/certbot/certbot certonly --email bkozdemba@gmail.com -d presto.eadgbe.net --standalone --dry-run
  217  docker run -it --rm --name certbot docker.io/certbot/certbot certonly --email bkozdemba@gmail.com -d presto.eadgbe.net --standalone --agree-tos --dry-run
  218  docker run -it --rm --name certbot docker.io/certbot/dns-cloudflare certonly --email bkozdemba@gmail.com -d presto.eadgbe.net --standalone --agree-tos --dry-run
  219  docker run -it --rm --name certbot docker.io/certbot/dns-cloudflare certonly --email bkozdemba@gmail.com -d presto.eadgbe.net --standalone --agree-tos --dry-run --help
  220  docker run -it --rm --name certbot docker.io/certbot/dns-godaddy certonly --email bkozdemba@gmail.com -d presto.eadgbe.net --standalone --agree-tos --dry-run --help
  221  docker run -it --rm --name certbot docker.io/certbot certonly --dns-godaddy --email bkozdemba@gmail.com -d presto.eadgbe.net --standalone --agree-tos --dry-run --help
  222  docker run -it --rm --name certbot docker.io/certbot/certbot certonly --dns-godaddy --email bkozdemba@gmail.com -d presto.eadgbe.net --standalone --agree-tos --dry-run --help
  223  docker run -it --rm --name certbot docker.io/certbot/certbot  --dns-godaddy --email bkozdemba@gmail.com -d presto.eadgbe.net --standalone --agree-tos --dry-run --help
  224  history
  225  docker run -it --rm --name certbot docker.io/certbot/certbot certonly --email bkozdemba@gmail.com -d eadgbe.net --standalone --dry-run
  226  docker run -it --rm --name certbot docker.io/certbot/certbot certonly --email bkozdemba@gmail.com -d eadgbe.net --dns-godaddy --agree-tos --dry-run
  227  docker login --help
  228  docker login -u demo-p 0pen\$hiftr0x presto.eadgbe.net:8443
  229  docker login -u demo -p "0pen\$hiftr0x" presto.eadgbe.net:8443
  230  docker pull presto.eadgbe.net:8443/rhel-atomic
  231  docker rmi presto.eadgbe.net:8443/rhel-atomic
  232  docker images
  233  lvs
  234  docker pull presto.eadgbe.net:8443/rhel-atomic
  235  docker images
  236  docker rmi 68a151d90449
  237  docker pull presto.eadgbe.net:8443/rhel-atomic
  238  docker image|grep atomic
  239  docker images|grep atomic
  240  for i in presto.eadgbe.net:8443/rhel-atomic registry.access.redhat.com/rhel-atomic docker-registry-default.apps.eadgbe.net/push/rhel-atomic registry.access.redhat.com/rhel-atomic ; do docker rmi $i; done
  241  docker images|grep atomic
  242  for i in presto.eadgbe.net:8443/rhel-atomic registry.access.redhat.com/rhel-atomic docker-registry-default.apps.eadgbe.net/push/rhel-atomic registry.access.redhat.com/rhel-atomic ; do docker rmi $i; done
  243  docker images|grep atomic
  244  docker rmi registry.access.redhat.com/rhel-atomic
  245  docker rmi registry.access.redhat.com/rhel-atomic:<none>
  246  docker rmi 68a151d90449
  247  docker images
  248  docker pull presto.eadgbe.net:8443/rhel-atomic
  249  docker run presto.eadgbe.net:8443/rhel-atomic bash
  250  ls
  251  ps -ef
  252  exit
  253  docker run -it presto.eadgbe.net:8443/rhel-atomic bash
  254  ls
  255  docker run -it --rm --name certbot docker.io/certbot/certbot renew --email bkozdemba@gmail.com -d presto.eadgbe.net --standalone --agree-tos --dry-run
  256  docker run -it --rm --name certbot docker.io/certbot/certbot certbot-apache --email bkozdemba@gmail.com -d presto.eadgbe.net --agree-tos --dry-run
  257  docker run -it --rm --name certbot docker.io/certbot/certbot-apache --email bkozdemba@gmail.com -d presto.eadgbe.net --agree-tos --dry-run
  258  docker run -it --rm --name certbot docker.io/certbot/certbot --apache --email bkozdemba@gmail.com -d presto.eadgbe.net --agree-tos --dry-run
  259  docker run -it --rm --name certbot docker.io/certbot/certbot --apache --help all
  260  docker run -it --rm --name certbot docker.io/certbot/certbot --standalone --help all
  261  history
  262  docker run -it --rm --name certbot docker.io/certbot/certbot renew --email bkozdemba@gmail.com -d presto.eadgbe.net --standalone --agree-tos --dry-run
  263  docker run -it --rm --name certbot docker.io/certbot/certbot certonly --email bkozdemba@gmail.com -d presto.eadgbe.net --standalone --agree-tos --dry-run
  264  ls
  265  vim run-elasticsearch.sh
  266  vim run-elastic.sh
  267  sh run-elastic.sh
  268  docker ps
  269  docker logs elasticsearch
  270  docker logs elasticsearch|less
  271  docker ps
  272  docker rm -f elasticsearch kibana
  273  vim run-elastic.sh
  274  sysctl -w vm.max_map_count=262144
  275  vim run-elastic.sh
  276  sh ./run-elastic.sh 
  277  docker logs elasticsearch|less
  278  docker logs elasticsearch --follow
  279  cat run-elastic.sh 
  280  docker login -u demo -p open\$hiftr0x reg.koz.redhatgov.io 
  281  docker login -u demo -p 0pen\$hiftr0x reg.koz.redhatgov.io 
  282  ls
  283  systemctl start httpd
  284  netstat -tulpn
  285  netstat -tulpn|grep 443
  286  netstat -tulpn|grep 80
  287  dnf search mod_ssl
  288  dnf install mod_ssl
  289  ls
  290  ls /var/www/html/
  291  hostname
  292  docker run -it --rm --name certbot docker.io/certbot/certbot certonly --manual --preferred-challenges http --email bkozdemba@gmail.com -d triad.eadgbe.net --agree-tos --dry-run
  293  ls /etc/letsencrypt/
  294  ls /etc/letsencrypt/archive/
  295  ls /etc/letsencrypt/accounts/
  296  docker run -it --rm --name certbot docker.io/certbot/certbot certonly --manual --preferred-challenges http --email bkozdemba@gmail.com -d triad.eadgbe.net --agree-tos 
  297  cp /etc/letsencrypt/live/triad.eadgbe.net/fullchain.pem /etc/pki/tls/certs/triad.eadgbe.net.crt
  298  docker run -it --rm --name certbot docker.io/certbot/certbot certonly -v /etc/letsencrypt:/etc/letsencrypt --manual --preferred-challenges http --email bkozdemba@gmail.com -d triad.eadgbe.net --agree-tos 
  299  docker run -it --rm --name certbot -v /etc/letsencrypt:/etc/letsencrypt docker.io/certbot/certbot certonly --manual --preferred-challenges http --email bkozdemba@gmail.com -d triad.eadgbe.net --agree-tos 
  300  cp /etc/letsencrypt/live/triad.eadgbe.net/fullchain.pem /etc/pki/tls/certs/triad.eadgbe.net.crt
  301  cp /etc/letsencrypt/live/triad.eadgbe.net/privkey.pem /etc/pki/tls/private/triad.eadgbe.net-key.crt
  302  ls /etc/letsencrypt/live/
  303  vim /etc/httpd/conf.d/ssl.conf 
  304  systemctl restart httpd
  305  firewall-cmd --list-services
  306  firewall-cmd --list-ports
  307  firewall-cmd --add-services https
  308  firewall-cmd --add-service https
  309  firewall-cmd --add-service https -permanent
  310  firewall-cmd --add-service https --permanent
  311  firewall-cmd --list-services
  312  vim /var/www/html/.htaccess
  313  vim /etc/httpd/conf/httpd.conf 
  314  systemctl restart httpd
  315  dnf update
  316  history
  317  docker run -it --rm --name certbot -v /etc/letsencrypt:/etc/letsencrypt docker.io/certbot/certbot renew --manual --preferred-challenges http --email bkozdemba@gmail.com -d triad.eadgbe.net --agree-tos --dry-run
  318  docker run -it --rm --name certbot -v /etc/letsencrypt:/etc/letsencrypt docker.io/certbot/certbot renew --help
  319  docker run -it --rm --name certbot -v /etc/letsencrypt:/etc/letsencrypt docker.io/certbot/certbot certonly --help
  320  docker run -it --rm --name certbot -v /etc/letsencrypt:/etc/letsencrypt docker.io/certbot/certbot renew --help
  321  docker run -it --rm --name certbot -v /etc/letsencrypt:/etc/letsencrypt docker.io/certbot/certbot certificates --help
  322  docker run -it --rm --name certbot -v /etc/letsencrypt:/etc/letsencrypt docker.io/certbot/certbot certificates 
  323  docker run -it --rm --name certbot -v /etc/letsencrypt:/etc/letsencrypt docker.io/certbot/certbot renew
  324  ls
  325  rm -rf letsencrypt-etc-.bak/
  326  cp -r /etc/letsencrypt/ etc-letsencrypt.bak/
  327  ls
  328  echo "Z_6qVi45eYkOFGfL_EXySS-5vv6AVEohmYEBbiWrP6U._gHhb8I390MwnZqZzAeFswQgk2VO4IK8aERSEzRENSQ"
  329  echo "Z_6qVi45eYkOFGfL_EXySS-5vv6AVEohmYEBbiWrP6U._gHhb8I390MwnZqZzAeFswQgk2VO4IK8aERSEzRENSQ" >> /var/www/html/.well-known/acme-challenge/Z_6qVi45eYkOFGfL_EXySS-5vv6AVEohmYEBbiWrP6U
  330  mkdir /var/www/html/.well-known/acme-challenge/
  331  mkdir -p /var/www/html/.well-known/acme-challenge/
  332  echo "Z_6qVi45eYkOFGfL_EXySS-5vv6AVEohmYEBbiWrP6U._gHhb8I390MwnZqZzAeFswQgk2VO4IK8aERSEzRENSQ" >> /var/www/html/.well-known/acme-challenge/Z_6qVi45eYkOFGfL_EXySS-5vv6AVEohmYEBbiWrP6U
  333  echo "rfqCBYQWBS1vjd7fr-lWNZltCqghXSbAaHKOQUEr1vk.w2_Sw9hb2o2UjZQb1MB2vUHOHBskWPzR_s_AQ6JRg0k" >> /var/www/html/.well-known/acme-challenge/rfqCBYQWBS1vjd7fr-lWNZltCqghXSbAaHKOQUEr1vk
  334  echo "EHBCc02rhCVOBFV6NuWxHXEiOIOyUM8VHTxF0ECWFnU.egjdWZsE2ULuC5v5KUUnNTwzov6dhsfHTqeZ-zuN6gk" >> /var/www/html/.well-known/acme-challenge/EHBCc02rhCVOBFV6NuWxHXEiOIOyUM8VHTxF0ECWFnU
  335  mkdir /var/www/html/images
  336  cd /home/bkozdemb/
  337  ls
  338  cd heel/
  339  ls
  340  cd 0001/01/
  341  ls
  342  ls -l
  343  ls -l *.jpg
  344  cp I0010001.jpg /var/www/html/images/back.jpg
  345  cp I0020001.jpg /var/www/html/images/side.jpg
  346  cd /var/www/html/
  347  ls
  348  rm -rf june212018/
  349  ls
  350  df -h
  351  history
  352  free -h
  353  systemctl status httpd
  354  systemctl enable httpd
  355  dnf update
  356  sync
  357  reboot
  358  cd /var/www/html/calc
  359  ls
  360  vim index.html
  361  ls
  362  mv hp15c.jar HP15C.jar
  363  vim index.html
  364  ls
  365  jar tvf HP15C.jar 
  366  jar tvf HP15C.jar |less
  367  ls
  368  cd /usr/tmp
  369  git clone https://github.com/ghewgill/hp15c.git
  370  ls
  371  ls hp15c/
  372  cp -r hp15c/ /var/www/html
  373  cd /var/www/html
  374  ls
  375  rm -rf calc/
  376  cd hp15c/
  377  ls
  378  ls web
  379  ls
  380  find . -name "*.class"
  381  find . -name "*.jar"
  382  ls common/
  383  ls web
  384  ls swing/
  385  ls
  386  exit
  387  docker rmi 1234e32f40df a80ef6c004f0 7410eb786e5b 328edcd84f1b 50de54591abb 00ff3a8e4732 93ca8e54e48e 942c0df3f583
  388  lvs
  389  ls swing/
  390  docker images
  391  docker rmi d1e32b95d8e8
  392  docker images
  393  ls
  394  exit
  395  dnf search piwigo
  396  id
  397  docker ps
  398  ls
  399  cp run-elastic.sh run-piwigo.sh
  400  vim run-piwigo.sh
  401  docker ps
  402  docker exec -it mariadb
  403  docker exec -it mariadb bash
  404  docker inspect mariadb
  405  docker exec -it mariadb
  406  docker exec -it mariadb bash
  407  docker rm -f mariadb
  408  ls
  409  cat run-piwigo.sh 
  410  docker run --restart=always --name=mariadb --detach -e MYSQL_ROOT_PASSWORD=piwigo        -e MYSQL_DATABASE=piwigo -e MYSQL_USER=piwigo -e MYSQL_PASSWORD=piwigo -p 3306:3306 
  411  cat run-piwigo.sh 
  412  docker run --restart=always --name=mariadb --detach -e MYSQL_ROOT_PASSWORD=piwigo        -e MYSQL_DATABASE=piwigo -e MYSQL_USER=piwigo -e MYSQL_PASSWORD=piwigo -p 3306:3306 -v /pv/mariadb:/var/lib/mysql docker.io/mysql
  413  docker ps
  414  ®exec®
  415  docker exec -it mariadb bash
  416  docker logs mariadb
  417  docker rm -f mariadb
  418  ls /pv/mariadb/
  419  ls -a /pv/mariadb/
  420  rm -rf /pv/mariadb/*
  421  docker run --restart=always --name=mariadb --detach -e MYSQL_ROOT_PASSWORD=piwigo        -e MYSQL_DATABASE=piwigo -e MYSQL_USER=piwigo -e MYSQL_PASSWORD=piwigo -p 3306:3306 -v /pv/mariadb:/var/lib/mysql docker.io/mysql
  422  docker logs mariadb
  423  docker logs mariadb --follow
  424  env
  425  docker exec -it mariadb bash
  426  ls
  427  vim run-piwigo.sh 
  428  sh run-piwigo.sh 
  429  docker ps
  430  docker network lidt
  431  docker network ls
  432  docker network inspect isolated_nw
  433  cat run-piwigo.sh 
  434  docker network inspect isolated_nw
  435  docker ps
  436  docker inspect piwigo
  437  docker inspect piwigo|grep IP
  438  docker inspect mariadb|grep IP
  439  docker stop piwigo mariadb
  440  docker rm -f piwigo mariadb
  441  ls
  442  vim run-piwigo.sh 
  443  ls /config
  444  ls /pv/piwigo/config
  445  ls /pv/piwigo
  446  ls /pv/piwigo/www
  447  ls /pv/piwigo/www/gallery/galleries/
  448  du -sh /pv/piwigo/www/gallery/galleries/*
  449  du -sh /pv/piwigo/www/gallery/*
  450  du -sh /pv/piwigo/www/gallery/upload/
  451  du -sh /pv/piwigo/www/gallery/upload/2018/08/01/
  452  docker start mariadb
  453  ls
  454  sh ./run-piwigo.sh 
  455  docker ps
  456  cat run-piwigo.sh 
  457  vim run-piwigo.sh 
  458  ls
  459  vim run-piwigo.sh 
  460  sh ./run-piwigo.sh 
  461  vim run-piwigo.sh 
  462  cat run-piwigo.sh
  463  export TAG=latest
  464  docker run --restart=always --name=piwigo --detach -p 9001:80 --link mariadb:mariadb -v /pv/piwigo:/config docker.io/linuxserver/piwigo:$TAG
  465  docker ps
  466  docker logs piwigo
  467  docker rm -f mariadb
  468  cat run-piwigo.sh 
  469  vim run-piwigo.sh 
  470  docker run --restart=always --name=mariadb --detach -e MYSQL_ROOT_PASSWORD=mariadb \ 
  471         -e MYSQL_DATABASE=piwigo -e MYSQL_USER=piwigo -e MYSQL_PASSWORD=piwigo -p 3306:3306         -v /pv/mariadb:/var/lib/mysql docker.io/mariadb:$TAG
  472  export TAG=latest
  473  cat run-piwigo.sh 
  474  docker run --restart=always --name=mariadb --detach -e MYSQL_ROOT_PASSWORD=mariadb        -e MYSQL_DATABASE=piwigo -e MYSQL_USER=piwigo -e MYSQL_PASSWORD=piwigo -p 3306:3306 -v /pv/mariadb:/var/lib/mysql docker.io/mariadb:$TAG
  475  docker ps
  476  ip a
  477  docker inspect mariadb
  478  docker inspect mariadb|grep -i host
  479  docker exec -it mariadb bash
  480  docker exec -it piwigo bash
  481  docker ps
  482  docker exec -it piwigo bash
  483  ip a|grep docker
  484  docker inpsect mariadb
  485  docker inspect mariadb
  486  docker exec -it mariadb bash
  487  cat run-piwigo.sh w
  488  vim run-piwigo.sh 
  489  cat run-piwigo.sh
  490  docker rm -f mariadb
  491  docker run --restart=always --name=mariadb --detach -e MYSQL_ROOT_PASSWORD=piwigo        -e MYSQL_DATABASE=piwigo -e MYSQL_USER=piwigo -e MYSQL_PASSWORD=piwigo -p 3306:3306 -v /pv/mariadb:/var/lib/mysql docker.io/mariadb:$TAG
  492  docker logs mariadb
  493  docker logs mariadb --follow
  494  docke rps
  495  docker ps
  496  docker inspect mariadb
  497  docker ps
  498  docker exec -it mariadb
  499  docker exec -it mariadb bash
  500  docker pd
  501  docker ps
  502  docker inspect piwigo
  503  docker exec -it piwigo bash
  504  docker rm -f piwigo
  505  cat run-piwigo.sh 
  506  docker run --restart=always --name=piwigo --detach -p 9001:80 -v /pv/piwigo:/config docker.io/linuxserver/piwigo:latest
  507  docker exec -it piwigo bash
  508  docker logs piwigo
  509  docker logs piwigo --follow
  510  docker rm -f piwigo
  511  cat run-piwigo.sh 
  512  docker run --restart=always --name=piwigo --detach -p 9001:80 -v /pv/piwigo:/config -e PGID=0 -e PUID=0 -e TZ=CDT6CST docker.io/linuxserver/piwigo:latest
  513  docker logs piwigo --follow
  514  docker rm -f piwigo
  515  docker run --restart=always --name=piwigo --detach -p 9001:80 -v /pv/piwigo:/config  -e TZ=$TZ docker.io/linuxserver/piwigo:latest
  516  docker logs piwigo --follow
  517  ip a
  518  docker rm -f piwigo
  519  echo $TZ
  520  docker run --restart=always --name=piwigo --detach -p 9001:80 -v /pv/piwigo:/config  -e TZ="Europe/London" docker.io/linuxserver/piwigo:latest
  521  docker run --restart=always --name=mysql --detach -e MYSQL_ROOT_PASSWORD=piwigo -e MYSQL_DATABASE=piwigo -e MYSQL_USER=piwigo -e MYSQL_PASSWORD=piwigo -p 4306:3306  docker.io/mariadb:$TAG
  522  docker exec -it mysql bash
  523  mysql
  524  docker ps
  525  docker docker -it piwigo /bin/bash
  526  docker exec  -it piwigo /bin/bash
  527  docker ps
  528  docker rm -f mysql piwigo mariadb
  529  docker network create -d bridge --subnet 172.25.0.0/16 isolated_nw
  530  docker pd
  531  docker ps
  532  docker logs mariadb
  533  docker ps
  534  docker rm -rf mariadb piwigo
  535  docker rm -f mariadb piwigo
  536  vim run-piwigo.sh 
  537  rm -rf /pv/mariadb/*
  538  export TAG=latest
  539  cat run-piwigo.sh 
  540  docker run --network=isolated_nw --ip=172.25.3.3 --restart=never --name=mariadb --detach -e MYSQL_ROOT_PASSWORD=piwigo        -e MYSQL_DATABASE=piwigo -e MYSQL_USER=piwigo -e MYSQL_PASSWORD=piwigo -p 3306:3306 -v /pv/mariadb:/var/lib/mysql docker.io/mariadb:$TAG
  541  man docker-run
  542  vim run-piwigo.sh 
  543  docker run --network=isolated_nw --ip=172.25.3.3 --restart=no --name=mariadb --detach -e MYSQL_ROOT_PASSWORD=piwigo        -e MYSQL_DATABASE=piwigo -e MYSQL_USER=piwigo -e MYSQL_PASSWORD=piwigo -p 3306:3306 -v /pv/mariadb:/var/lib/mysql docker.io/mariadb:$TAG
  544  docker ps
  545  docker logs mariadb
  546  cat run-piwigo.sh 
  547  docker run --network=isolated_nw --ip=172.25.3.4 --restart=no --name=piwigo --detach -p 9001:80 --link mariadb:mariadb -v /pv/piwigo:/config docker.io/linuxserver/piwigo:$TAG
  548  docker ps
  549  docker logs piwigo
  550  cd /var/www/html
  551  ls
  552  cd july282018/
  553  ls
  554  rm -rf buda/
  555  ls
  556  cd alicePatrick07282018/
  557  ls
  558  ls *.m4v
  559  rm -f *.jpg
  560  ls
  561  pwd
  562  cd ..
  563  ls
  564  mv alicePatrick07282018 alicePatrickVideo07282018
  565  ls
  566  mv alicePatrickVideo07282018/ ..
  567  cd ..
  568  ls
  569  rm -rf july282018/
  570  ls
  571  cd alicePatrickVideo07282018
  572  ls
  573  rm IMG_0831.m4v 
  574  rm IMG_4552.m4v 
  575  ls
  576  exit
  577  docker exec -it piwigo /bin/bash
  578  ls
  579  vim run-piwigo.sh 
  580  dnf update
  581  sync
  582  reboot
  583  sync
  584  shutdown -h now
  585  docker images
  586  ls
  587  docker ps
  588  exit
  589  docker ps
  590  docker ps -a
  591  docker start mariadb
  592  docker start piwigo
  593  docker ps 
  594  docker start workshopper-consec
  595  docker ps 
  596  cd /var/www/html/
  597  lks
  598  ls
  599  mkdir dashcam
  600  cd dashcam/
  601  cp /home/bkozdemb/media/dashcam/classicalGroceryStop.m4v .
  602  ls
  603  ls -l
  604  cd ..
  605  ls -l
  606  dnf update
  607  sync
  608  reboot
  609  shutdown -h now
  610  docker ps
  611  docker ps -a
  612  docker start mariadb
  613  docker start piwigo
  614  docker ps -a
  615  docker ps 
  616  docker start workshopper-consec 
  617  exit
  618  virt-manager 
  619  df -h
  620  cd /var/www/html/dashcam/
  621  df
  622  ls -l /run/media/bkozdemb/DRIVEHD
  623  ls -l /run/media/bkozdemb/DRIVEHD/DCIM/
  624  ls -l /run/media/bkozdemb/DRIVEHD/DCIM/100_DSC/
  625  totem /run/media/bkozdemb/DRIVEHD/DCIM/100_DSC/20180806_0037_CAM1_VID.MOV
  626  cp /run/media/bkozdemb/DRIVEHD/DCIM/100_DSC/20180806_0037_CAM1_VID.MOV pullinIn.m4v
  627  ls -l
  628  totem pullinIn.m4v 
  629  cat run-piwigo.sh 
  630  exit
  631  docker exec -it piwigo bash
  632  ls
  633  docker rsync
  634  docker help
  635  docker export --help
  636  cd /usr/tmp
  637  ls
  638  mkdir piwigo
  639  cd piwigo/
  640  docker export piwigo -o piwigo.tar
  641  ls
  642  ls -l
  643  tar tvf piwigo.tar 
  644  tar tvf piwigo.tar config
  645  tar xvf piwigo.tar config
  646  ls config/
  647  tar tvf piwigo.tar 
  648  tar tvf piwigo.tar |grep config
  649  tar tvf piwigo.tar |grep config|more
  650  docker ssh piwigo bash
  651  docker exec -it piwigo bash
  652  ls
  653  ls config/
  654  rm -rf config/
  655  tar xf piwigo.tar 
  656  ls
  657  ls config/
  658  find . -name config
  659  docker export piwigo -o piwigo.tar
  660  ls
  661  rm *
  662  rm -rf *
  663  ls
  664  docker export piwigo -o piwigo.tar
  665  mkdir fs
  666  cd fs
  667  tar xvf ../piwigo.tar 
  668  ls
  669  find . -name nginx
  670  ls etc/nginx/
  671  ls etc/nginx/nginx.conf 
  672  less etc/nginx/nginx.conf 
  673  ls etc/nginx/conf.d/
  674  docker exec -it piwigo bash
  675  find . -name site-confs
  676  find . -name default
  677  ls
  678  ls pictures/
  679  man docker-export
  680  cd ..
  681  ls
  682  rm -rf fs/*
  683  rm piwigo.tar 
  684  docker export piwigo > piwigo.tar
  685  ls -l piwigo.tar 
  686  du -sh piwigo.tar 
  687  docker exec -it piwigo bash
  688  rm piwigo.tar 
  689  ls
  690  ls /
  691  ls /pv/piwigo/
  692  ls /pv/piwigo/nginx/
  693  ls /pv/piwigo/nginx/site-confs/
  694  ls
  695  du -sh /pv/piwigo/
  696  cd /pv/piwigo/
  697  ls
  698  ls nginx/
  699  cp -r nginx /usr/tmp
  700  cd /usr/tmp
  701  chown -R bkozdemb:bkozdemb nginx/
  702  cd /pv/piwigo/
  703  ls
  704  grep -r s6 .
  705  grep -r "/var/run/s6" .
  706  grep -r "mkdir" .
  707  grep -r "var" .
  708  grep -r "/var" .
  709  grep -r "/var/run" .
  710  docker ps
  711  docker exec -it piwigo
  712  docker exec -it piwigo bash
  713  ls
  714  cat letsencrypt.txt 
  715  grep -r "/var" .
  716  docker exec -it piwigols
  717  ls
  718  cat letsencrypt.sh
  719  ls
  720  exit
  721  history|grep openssl
  722  openssl crl2pkcs7 -nocrl -certfile /etc/letsencrypt/live/reg.koz.redhatgov.io/fullchain.pem | openssl pkcs7 -print_certs -noout
  723  dnf update
  724  sync
  725  reboot
  726  ls
  727  docker ps
  728  docker ps -a
  729  docker start mariab piwigo
  730  docker start mariadb piwigo
  731  docker rm workshopper-local
  732  docker rm kibana elasticsearch
  733  docker ps
  734  docker ps -a
  735  dnf update
  736  sync
  737  reboot
  738  docker ps
  739  docker ps -a
  740  docker start workshopper-consec
  741  docker ps 
  742  docker mariadb
  743  docker start mariadb
  744  docker start piwigo
  745  dnf update
  746  sync
  747  reboot
  748  docker ps
  749  docker ps -a
  750  docker start mariadb
  751  docker start piwigo
  752  docker start workshopper-consec
  753  docker ps
  754  docker exec -it musing_bose bash
  755  man docker
  756  man docker-cp
  757  ls
  758  docker exec -it musing_bose ls /app
  759  docker exec -it musing_bose ls /app/vars
  760  docker exec -it musing_bose ls /
  761  docker exec -it musing_bose ls /app_keys
  762  docker cp musing_bose:/app_keys /usr/tmp
  763  ls /usr/tmp
  764  ls /usr/tmp/app_keys/
  765  ssh -i /usr/tmp/app_keys/ocp-bkoz-redhatgov-io.pem ec2-user@ec2-52-52-210-167.us-west-1.compute.amazonaws.com
  766  ssh -i /usr/tmp/app_keys/ocp-bkoz-redhatgov-io.pem ec2-user@ec2-13-56-51-50.us-west-1.compute.amazonaws.com
  767  ls
  768  docker ps
  769  docker rm -f musing_bose
  770  docker ps
  771  docker ps -a
  772  exit
  773  docker ps
  774  docker images
  775  docker ps
  776  docker exec -it clever_haibt bash
  777  exit
  778  docker images
  779  docker ps
  780  docker exec -it clever_haibt
  781  docker exec -it clever_haibt bash
  782  dnf update -y
  783  sync
  784  reboot
  785  docker ps
  786  docker ps -a
  787  docker start mariadb piwigo workshopper-consec
  788  dnf update -y
  789  sync
  790  reboot
  791  ls
  792  docker ps
  793  docker exec -it compassionate_euclid
  794  docker exec -it compassionate_euclid bash
  795  docker copy compassionate_euclid:/app_keys .
  796  man docker
  797  docker cp compassionate_euclid:/app_keys .
  798  ls
  799  ls app_keys/
  800  ssh -i app_keys/ocp-bkoz-redhatgov-io.pem ec2-user@ec2-54-219-235-11.us-west-1.compute.amazonaws.com
  801  cd /usr/tmp/app_keys/
  802  ls
  803  ssh -i ocp-koz-redhatgov-io.pem ec2-user@ec2-13-56-91-158.us-west-1.compute.amazonaws.com
  804  ls
  805  docker exec -it compassionate_euclid bash
  806  docker ps
  807  docker exec -it loving_dubinsky bash
  808  ssh -i app_keys/ocp-bkoz-redhatgov-io.pem ec2-user@ec2-54-219-235-11.us-west-1.compute.amazonaws.com
  809  ls
  810  ssh -i app_keys/ocp-bkoz-redhatgov-io.pem ec2-user@ec2-13-56-91-158.us-west-1.compute.amazonaws.com
  811  do9cker 
  812  docker ps
  813  docker ps -a
  814  docker start mariadb piwigo workshopper-consec
  815  docker cp compassionate_euclid:/app_keys .
  816  docker ps
  817  docker cp jolly_tesla:/app_keys .
  818  ls 
  819  ls app_keys
  820  ls -l app_keys
  821  ssh -i app_keys/ocp-koz-redhatgov-io.pem ec2-user@ec2-13-56-91-158.us-west-1.compute.amazonaws.com
  822  ls
  823  ls /usr/tmp
  824  ls /usr/tmp/openshift-provision/
  825  cd /usr/tmp/app_keys/
  826  l;s
  827  ls
  828  ls /
  829  cd /usr/tmp
  830  ls
  831  ls app_keys/
  832  rm -rf app_keys/
  833  docker cp jolly_tesla:/app_keys .
  834  ls
  835  ls app_keys/
  836  ls /home/bkozdemb/
  837  ssh -i app_keys/ocp-koz-redhatgov-io.pem ec2-user@ec2-13-56-91-158.us-west-1.compute.amazonaws.com
  838  scp -i app_keys/ocp-koz-redhatgov-io.pem /home/bkozdemb/v310.hosts ec2-user@ec2-13-56-91-158.us-west-1.compute.amazonaws.com:
  839  ssh -i app_keys/ocp-koz-redhatgov-io.pem ec2-user@ec2-13-56-91-158.us-west-1.compute.amazonaws.com
  840  ssh -i app_keys/ocp-koz-redhatgov-io.pem ec2-user@ec2-54-177-187-246.us-west-1.compute.amazonaws.com
  841  ssh -i app_keys/ocp-koz-redhatgov-io.pem ec2-user@ec2-13-56-91-158.us-west-1.compute.amazonaws.com
  842  scp -i app_keys/ocp-koz-redhatgov-io.pem ec2-user@ec2-13-56-91-158.us-west-1.compute.amazonaws.com:v310.hosts .
  843  cp v310.hosts /usr/tmp/openshift-install/inventory/
  844  cd /usr/tmp/openshift-install/inventory/
  845  ls -l
  846  chown bkozdemb:bkozdemb v310.hosts 
  847  ls -l
  848  ls
  849  pwd
  850  ls
  851  cp pwed
  852  pwd
  853  ls
  854  ls /usr/tmp/app_keys/
  855  cp /usr/tmp/app_keys/ocp-koz-redhatgov-io.pem ~/.ssh/
  856  chown bkozdemb:bkozdemb ~/.ssh/ocp-koz-redhatgov-io.pem 
  857  chmod 600 ~/.ssh/ocp-koz-redhatgov-io.pem 
  858  mv ~/.ssh/ocp-koz-redhatgov-io.pem /home/bkozdemb/.ssh
  859  ls app
  860  ls
  861  ssh -i /usr/tmp/app_keys/ocp-koz-redhatgov-io.pem ec2-user@ec2-13-56-91-158.us-west-1.compute.amazonaws.com
  862  cd /usr/tmp/app_keys/
  863  ls -l
  864  ssh -i openshift-bkozdemb-redhatgov-io.pem ec2-user@ec2-13-52-14-164.us-west-1.compute.amazonaws.com
  865  cd /usr/tmp/app_keys/
  866  ls
  867  ssh -i openshift-bkozdemb-redhatgov-io.pem ec2-user@ec2-13-56-205-127.us-west-1.compute.amazonaws.com
  868  docker ps
  869  ls
  870  rm *
  871  ls
  872  docker cp compassionate_khorana:/app_keys /usr/tmp
  873  ls
  874  ssh -i openshift-bkozdemb-redhatgov-io.pem ec2-user@ec2-13-56-205-127.us-west-1.compute.amazonaws.com
  875  docker ps
  876  docker exec -it boring_dijkstra bash
  877  docker cp boring_dijkstra:/app_keys/ocp-bkozdemb-redhatgov-io.pem /usr/tmp/app_keys
  878  ls /usr/tmp/app_keys/
  879  ssh -i /usr/tmp/app_keys/ocp-bkozdemb-redhatgov-io.pem ec2-user@ec2-13-56-128-53.us-west-1.compute.amazonaws.com
  880  ls
  881  scp /usr/tmp/app_keys/ocp-bkozdemb-redhatgov-io.pem ec2-user@ec2-13-56-128-53.us-west-1.compute.amazonaws.com:/etc/ansible/hosts v310-aws-gluster.hosts
  882  scp -i /usr/tmp/app_keys/ocp-bkozdemb-redhatgov-io.pem ec2-user@ec2-13-56-128-53.us-west-1.compute.amazonaws.com:/etc/ansible/hosts v310-aws-gluster.hosts
  883  ls
  884  ssh -i /usr/tmp/app_keys/ocp-bkozdemb-redhatgov-io.pem ec2-user@ec2-13-56-128-53.us-west-1.compute.amazonaws.com
  885  htpasswd
  886  htpasswd user1 test
  887  htpasswd -n user1 test
  888  htpasswd -nb user1 test
  889  htpasswd -nb admin 0pen\$hiftr0x
  890  htpasswd -nb demo 0pen\$hiftr0x
  891  docker psd
  892  docker ps
  893  docker cp elegant_shaw:/app_keys /usr/tmp
  894  ls /usr/tmp/app_keys/openshift-bkozdemb-redhatgov-io.pem 
  895  ssh -i /usr/tmp/app_keys/openshift-bkozdemb-redhatgov-io.pem openshift.bkozdemb.redhatgov.io
  896  ssh -i /usr/tmp/app_keys/openshift-bkozdemb-redhatgov-io.pem ec2-user@openshift.bkozdemb.redhatgov.io
  897  ssh -i /usr/tmp/app_keys/openshift-bkozdemb-redhatgov-io.pem ec2-user@ec2-13-52-14-167.us-west-1.compute.amazonaws.com
  898  ls -l /usr/tmp/app_keys
  899  ssh -i /usr/tmp/app_keys/openshift-bkozdemb-redhatgov-io.pem ec2-user@ec2-13-52-14-167.us-west-1.compute.amazonaws.com
  900  ssh -i /usr/tmp/app_keys/openshift-bkozdemb-redhatgov-io.pem ec2-user@ec2-13-52-14-164.us-west-1.compute.amazonaws.com
  901  dnf update
  902  docker ps
  903  docker stop piwigo mariadb workshopper-consec
  904  sync
  905  reboot
  906  yum search VirtualBox
  907  yum install VirtualBox
  908  VirtualBox 
  909  dnf install akmod-VirtualBox kernel-devel-4.18.8-200.fc28.x86_64
  910  akmods --kernels 4.18.8-200.fc28.x86_64 && systemctl restart systemd-modules-load.service
  911  VirtualBox 
  912  top
  913  docker ps -a
  914  docker start mariadb piwigo workshopper-consec
  915  top
  916  ls /usr/tmp/app_keys/
  917  cp /usr/tmp/app_keys/openshift-bkozdemb-redhatgov-io.pem /home/bkozdemb/.ssh/
  918  cd /home/bkozdemb/.ssh/
  919  ls -l
  920  chown bkozdemb:bkozdemb openshift-bkozdemb-redhatgov-io.pem 
  921  chmod 600 openshift-bkozdemb-redhatgov-io.pem 
  922  exit
  923  cd /var/www/html/.well-known/acme-challenge/
  924  ls
  925  echo "cQKZlm_fwYVyfQKKN8kgeOvzGNYtuIzTYgvYE-qituY.Uwxe8c7BI3Uh7E1b1QhZPHUfQOMrjzNhUbTzh2_-aSY" > cQKZlm_fwYVyfQKKN8kgeOvzGNYtuIzTYgvYE-qituY
  926  echo "ml_KQdwJ_MCwa9dCqYDIJ5qXiMlEVRXUctZrKcgeMXU.Qp-8yxMwsDGooyhkUc7cJ0ZgKG5faiqcMs43TpjZx5o" > ml_KQdwJ_MCwa9dCqYDIJ5qXiMlEVRXUctZrKcgeMXU
  927  ls
  928  ls -l
  929  cat ml_KQdwJ_MCwa9dCqYDIJ5qXiMlEVRXUctZrKcgeMXU
  930  wget http://triad.eadgbe.net/.well-known/acme-challenge/ml_KQdwJ_MCwa9dCqYDIJ5qXiMlEVRXUctZrKcgeMXU
  931  ls
  932  echo "ml_KQdwJ_MCwa9dCqYDIJ5qXiMlEVRXUctZrKcgeMXU.Qp-8yxMwsDGooyhkUc7cJ0ZgKG5faiqcMs43TpjZx5o"
  933  echo "ml_KQdwJ_MCwa9dCqYDIJ5qXiMlEVRXUctZrKcgeMXU.Qp-8yxMwsDGooyhkUc7cJ0ZgKG5faiqcMs43TpjZx5o" > ml_KQdwJ_MCwa9dCqYDIJ5qXiMlEVRXUctZrKcgeMXU
  934  wget http://triad.eadgbe.net/.well-known/acme-challenge/ml_KQdwJ_MCwa9dCqYDIJ5qXiMlEVRXUctZrKcgeMXU
  935  wget http://triad.eadgbe.net/.well-known/acme-challenge/
  936  wget http://triad.eadgbe.net
  937  wget http://triad.eadgbe.net/.well-known/acme-challenge/ml_KQdwJ_MCwa9dCqYDIJ5qXiMlEVRXUctZrKcgeMXU
  938  wget https://triad.eadgbe.net/.well-known/acme-challenge/ml_KQdwJ_MCwa9dCqYDIJ5qXiMlEVRXUctZrKcgeMXU
  939  cd /etc/letsencrypt/
  940  ls
  941  cd archive/
  942  ls
  943  cd triad.eadgbe.net/
  944  ls
  945  cd ..
  946  ls
  947  cd ..
  948  ls
  949  cd accounts/
  950  ls
  951  cd ../keys/
  952  ls
  953  ls
  954  ls /etc/letsencrypt/
  955  ls /etc/letsencrypt/live/
  956  ls /etc/letsencrypt/live/triad.eadgbe.net/
  957  cd /etc/letsencrypt/live/triad.eadgbe.net/
  958  ls
  959  ls -l
  960  cd ../../archive/
  961  ls
  962  cd triad.eadgbe.net/
  963  ls
  964  ls -l
  965  docker run -it --rm --name certbot -v /etc/letsencrypt:/etc/letsencrypt docker.io/certbot/certbot renew
  966  docker run -it --rm --name certbot docker.io/certbot/certbot certonly --manual --preferred-challenges http --email bkozdemba@gmail.com -d presto.eadgbe.net --agree-tos --dry-run
  967  docker run -it --rm --name certbot docker.io/certbot/certbot certonly --manual --preferred-challenges http --email bkozdemba@gmail.com -d triad.eadgbe.net --agree-tos --dry-run
  968  docker run -it --rm --name certbot docker.io/certbot/certbot certonly --manual --preferred-challenges https --email bkozdemba@gmail.com -d triad.eadgbe.net --agree-tos --dry-run
  969  docker run -it --rm --name certbot docker.io/certbot/certbot certonly --manual --preferred-challenges http --email bkozdemba@gmail.com -d presto.eadgbe.net --agree-tos --dry-run
  970  ls
  971  cd /etc/letsencrypt/archive/
  972  ls
  973  cd triad.eadgbe.net/
  974  ls
  975  docker run -it --rm --name certbot -v /etc/letsencrypt:/etc/letsencrypt docker.io/certbot/certbot renew
  976  docker run -it --rm --name certbot -v /etc/letsencrypt:/etc/letsencrypt docker.io/certbot/certbot renew --dryrun
  977  docker run -it --rm --name certbot -v /etc/letsencrypt:/etc/letsencrypt docker.io/certbot/certbot renew --dry-run
  978  docker run -it --rm --name certbot -v /etc/letsencrypt:/etc/letsencrypt docker.io/certbot/certbot renew --dry-run --preferred-challenges http
  979  docker run -it --rm --name certbot -v /etc/letsencrypt:/etc/letsencrypt docker.io/certbot/certbot renew --dry-run --manual
  980  docker run -it --rm --name certbot -v /etc/letsencrypt:/etc/letsencrypt docker.io/certbot/certbot renew --dry-run 
  981  docker run -it --rm --name certbot -v /etc/letsencrypt:/etc/letsencrypt docker.io/certbot/certbot bash
  982  docker run -it --rm --name certbot -d triad.eadgbe.net  docker.io/certbot/certbot renew
  983  docker run -it --rm --name certbot docker.io/certbot/certbot renew -d triad.eadgbe.net
  984  docker run -it --rm --name certbot docker.io/certbot/certbot certonly -d triad.eadgbe.net
  985  curl
  986  nslookup -q=TXT _acme-challenge.triad.eadgbe.net
  987  ls
  988  docker run -it --rm --name certbot -v /etc/letsencrypt:/etc/letsencrypt docker.io/certbot/certbot renew --dry-run --preferred-challenges tls-nsi
  989  docker run -it --rm --name certbot -v /etc/letsencrypt:/etc/letsencrypt docker.io/certbot/certbot renew --dry-run --preferred-challenges tls-sni
  990  docker run -it --rm --name certbot docker.io/certbot/certbot certonly --manual --preferred-challenges tls-sni --email bkozdemba@gmail.com -d triad.eadgbe.net --agree-tos --dry-run
  991  docker run -it --rm --name certbot docker.io/certbot/certbot certonly --manual --preferred-challenges http --email bkozdemba@gmail.com -d triad.eadgbe.net --agree-tos --dry-run
  992  nslookup -q=TXT _acme-challenge.triad.eadgbe.net
  993  dnf search certbot
  994  nslookup -q=TXT _acme-challenge.triad.eadgbe.net
  995  docker run -it --rm --name certbot docker.io/certbot/certbot certonly --manual --preferred-challenges http --email bkozdemba@gmail.com -d presto.eadgbe.net --agree-tos --dry-run
  996  docker run -it --rm --name certbot docker.io/certbot/certbot certonly --manual --preferred-challenges tls-nsi-01 --email bkozdemba@gmail.com -d triad.eadgbe.net --agree-tos --dry-run
  997  docker run -it --rm --name certbot docker.io/certbot/certbot certonly --manual --preferred-challenges tls-sni-01 --email bkozdemba@gmail.com -d triad.eadgbe.net --agree-tos --dry-run
  998  nslookup -q=TXT _acme-challenge.triad.eadgbe.net
  999  less /etc/httpd/conf.d/ssl.conf 
 1000  systemctl restart httpd
 1001  cd /etc/httpd/conf.d/
 1002  ls
 1003  cp ssl.conf ssl.conf.orig
 1004  vim ssl.conf
 1005  cd
 1006  ls
 1007  cat letsencrypt.sh 
 1008  ls
 1009  vim gen-install-certs.sh
 1010  cat gen-install-certs.sh 
 1011  certbot renew
 1012  ls /etc/letsencrypt/renewal/triad.eadgbe.net.conf 
 1013  cat /etc/letsencrypt/renewal/triad.eadgbe.net.conf 
 1014  ls
 1015  vim gen-install-certs.sh 
 1016  cat gen-install-certs.sh
 1017  cp /etc/letsencrypt/live/triad.eadgbe.net/fullchain.pem /etc/pki/tls/certs/triad.eadgbe.net.crt
 1018  systemctl restart httpd
 1019  ls /etc/pki/tls/cert
 1020  ls /etc/pki/tls/certs/
 1021  ls -l /etc/pki/tls/certs/triad.eadgbe.net.crt 
 1022  date
 1023  cp /etc/letsencrypt/live/triad.eadgbe.net/fullchain.pem /etc/pki/tls/certs/triad.eadgbe.net.crt
 1024  cp /etc/letsencrypt/live/triad.eadgbe.net/privkey.pem /etc/pki/tls/private/triad.eadgbe.net-key.crt
 1025  cp /etc/letsencrypt/live/triad.eadgbe.net/fullchain.pem /etc/pki/tls/certs/triad.eadgbe.net.crt
 1026  systemctl restart httpd
 1027  history
[root@triad ~]# diff /etc/letsencrypt/live/triad.eadgbe.net/fullchain.pem /etc/pki/tls/certs/triad.eadgbe.net.crt
[root@triad ~]# diff cp /etc/letsencrypt/live/triad.eadgbe.net/privkey.pem /etc/pki/tls/private/triad.eadgbe.net-key.crt
diff: extra operand '/etc/pki/tls/private/triad.eadgbe.net-key.crt'
diff: Try 'diff --help' for more information.
[root@triad ~]# diff /etc/letsencrypt/live/triad.eadgbe.net/privkey.pem /etc/pki/tls/private/triad.eadgbe.net-key.crt
[root@triad ~]# ls
anaconda-ks.cfg  Documents             grub2-theme-breeze  nexus-functions  run-gitlab.sh  run-piwigo.sh       v310-aws-gluster.hosts
app_keys         Downloads             letsencrypt.sh      Pictures         run-mysql.sh   run-registry.sh     Videos
backup.sh        etc-letsencrypt.bak   letsencrypt.txt     Public           run-nexus.sh   run-workshopper.sh
Desktop          gen-install-certs.sh  Music               run-elastic.sh   run-ocp.sh     Templates

# cat gen-install-certs.sh 
#!/bin/bash

certbot --apache -d triad.eadgbe.net

cp /etc/letsencrypt/live/triad.eadgbe.net/fullchain.pem /etc/pki/tls/certs/triad.eadgbe.net.crt
cp /etc/letsencrypt/live/triad.eadgbe.net/privkey.pem /etc/pki/tls/private/triad.eadgbe.net-key.crt

systemctl restart httpd

certbot renew
