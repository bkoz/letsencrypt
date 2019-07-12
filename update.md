Letsencrypt cert update 7/9/2019 for OpenShift v3.11

1) export AWS Credential variables

2) Edit and run the script.

```
# sh ./updatecerts.sh 

Generating a single cert w/multiple domains...

 - Congratulations! Your certificate and chain have been saved at:
   /etc/letsencrypt/live/koz-certtest.redhatgov.io/fullchain.pem
   Your key file has been saved at:
   /etc/letsencrypt/live/koz-certtest.redhatgov.io/privkey.pem
   Your cert will expire on 2019-10-07. To obtain a new or tweaked
   version of this certificate in the future, simply run certbot
   again. To non-interactively renew *all* of your certificates, run
   "certbot renew"
```
The new certs (```cert2.pem```, ```chain2.pem```, ```fullchain2.pem``` and ```privkey2.pem```) get put into 
the following directory.
```
# ls -l /etc/letsencrypt/archive/koz-certtest.redhatgov.io/
total 32
-rw-r-xr--+ 1 root root 1980 May  2 01:16 cert1.pem
-rw-r--r--. 1 root root 1980 Jul  9 19:04 cert2.pem
-rw-r-xr--+ 1 root root 1648 May  2 01:11 chain1.pem
-rw-r--r--. 1 root root 1647 Jul  9 19:04 chain2.pem
-rw-r-xr--+ 1 root root 3629 May  2 01:11 fullchain1.pem
-rw-r--r--. 1 root root 3627 Jul  9 19:04 fullchain2.pem
-rw-r-x---+ 1 root root 1704 Apr 30 03:10 privkey1.pem
-rw-r-x---. 1 root root 1704 Jul  9 19:04 privkey2.pem
```
New symbolic links should get created.

```
# ls -l /etc/letsencrypt/live/koz-certtest.redhatgov.io/
total 4
lrwxrwxrwx. 1 root root  49 Jul  9 19:04 cert.pem -> ../../archive/koz-certtest.redhatgov.io/cert2.pem
lrwxrwxrwx. 1 root root  50 Jul  9 19:04 chain.pem -> ../../archive/koz-certtest.redhatgov.io/chain2.pem
lrwxrwxrwx. 1 root root  54 Jul  9 19:04 fullchain.pem -> ../../archive/koz-certtest.redhatgov.io/fullchain2.pem
lrwxrwxrwx. 1 root root  52 Jul  9 19:04 privkey.pem -> ../../archive/koz-certtest.redhatgov.io/privkey2.pem
```

Confirm the Ansible inventory file points to the correct location
for the new certs (```/etc/letsencrypt/live/koz-certtest.redhatgov.io```)

API
---

3) Backup old certs and copy new certs into place.
```
# cp /etc/origin/master/named_certificates/privkey.pem /etc/origin/master/named_certificates/privkey1.pem
# cp /etc/origin/master/named_certificates/fullchain.pem /etc/origin/master/named_certificates/fullchain1.pem 
# cp /etc/letsencrypt/live/koz-certtest.redhatgov.io/privkey.pem /etc/origin/master/named_certificates
# cp /etc/letsencrypt/live/koz-certtest.redhatgov.io/fullchain.pem /etc/origin/master/named_certificates
```
4) Restart the API service.
```
# /usr/local/bin/master-restart api

2 (return code)
```
Router
------

5) Set ACLs (you can also copy the old certs file ACLs- see the ```setfacl(1)``` man page)
```
# setfacl -m u:ec2-user:rx /etc/letsencrypt/archive/koz-certtest.redhatgov.io/fullchain2.pem
# setfacl -m u:ec2-user:rx  /etc/letsencrypt/archive/koz-certtest.redhatgov.io/chain2.pem
# setfacl -m u:ec2-user:r-x -m group::--- /etc/letsencrypt/archive/koz-certtest.redhatgov.io/privkey2.pem
# setfacl -m u:ec2-user:r-x -m mask::r-x /etc/letsencrypt/archive/koz-certtest.redhatgov.io/cert2.pem
```
6) Run the playbook.
```
$ ansible-playbook playbooks/openshift-hosted/redeploy-router-certificates.yml
```
