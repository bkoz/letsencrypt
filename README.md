# letsencrypt

## Notes on installing and replacing letsencrypt certs on OpenShift.

The ```letsencrypt``` util and [zerossl](https://zerossl.com/) web site generate the following files:

account-key.txt - Account key

domain-key.txt - Private key or ```privkey.pem```.

domain-crt.txt - A bundle that contains the cert followed by the CA. This should be broken apart
into separate certs (main cert and CA) with a text editor. Also called ```fullchain.pem```. 

domain-csr.txt - Cert signing request (keep for renewal).

### zerossl

#### Online web tool

This online tool is useful when the letsencrypt util will not renew because it is too early.

Choose DNS verification and accept terms.

Copy/paste CSR from /etc/letsencrypt/csr/0000_csr-certbot.pem into web site OR
enter domains separated by a comma.

Example (make sure no spaces are present if you copy/paste from route 53 web console).
```
koz-self.redhatgov.io, *.apps.koz-self.redhatgov.io
```

Save CSR and account key.

Create the 2 TXT records in Route53

Allow 5 minutes or so to let the records propagate.

Test the TXT records

```
host -t TXT _acme-challenge.koz-self.redhatgov.io
_acme-challenge.koz-self.redhatgov.io descriptive text "0tF3JPaxMO9slql_T-Ozobq2XThL5Yh5r6vee6U_lDA"

host -t TXT _acme-challenge.apps.koz-self.redhatgov.io
_acme-challenge.apps.koz-self.redhatgov.io descriptive text "_v1W_SaTpAPYwR9ugIG0w5Dq9dPUibesCyToPeFMpgo"
```

Download the cert and private key. You should now have 4 files in total.

```account-key.txt``` - Account key 
```domain-crt.txt``` - Cert bundle (Main cert + CA)
```domain-csr.txt``` - CSR (used for renewals)
```domain-key.txt``` - Private key

The ```domain-crt.txt``` file may be broken into separate cert and CA cert files using an editor. 
OpenShft 3 will require separate files.

### letsencrypt util output

Same files as the web tool produces but they are named different.

```privkey.pem``` - Private key
```chain.pem``` - CA cert
```cert.pem``` - Main Cert
```fullchain.pem``` - Main + CA cert combo

How to check that a private key matches the cert.

```
openssl x509 -noout -modulus -in fullchain.pem | openssl md5
(stdin)= 5d3f4caa1fc264d2dc8064fcb58a9a74

openssl rsa -noout -modulus -in privkey.pem | openssl md5
(stdin)= 5d3f4caa1fc264d2dc8064fcb58a9a74
```

[https://kb.wisc.edu/middleware/4064](https://kb.wisc.edu/middleware/4064)

### OpenShift

#### New installs or replacing self-signed after installation.

Create (2) DNS records for the api (1 for internal, 1 for public). Both URLs should point to the same
load balancer IP.

Set the proper Ansible inventory variables.

```
# URLs
openshift_master_cluster_hostname=internal-openshift.example.com
openshift_master_cluster_public_hostname=openshift.example.com

# API
openshift_master_overwrite_named_certificates=false
openshift_master_named_certificates=[{"certfile": "$HOME/certs/koz-self.redhatgov.io/fullchain.pem", "keyfile": "$HOME/certs/koz-ocs.redhatgov.io/privkey.pem", "names": ["koz-self.redhatgov.io"]}]

# Router
openshift_hosted_router_certificate={"certfile": "$HOME/certs/koz-self.redhatgov.io/cert.pem", "keyfile": "$HOME/certs/koz-self.redhatgov.io/privkey.pem", "cafile": "$HOME/certs/koz-self.redhatgov.io/chain.pem"}
```

If the certificates are not new, for example, you want to change existing certificates or replace expired certificates change to the playbook directory and run the following playbook:

```
ansible-playbook /usr/share/ansible/openshift-ansible/playbooks/redeploy-certificates.yml
```

#### Changing the publicURL

https://access.redhat.com/solutions/2362011

#### Upgrades 

Replacing **existing** named certificates.

#### Router

dir: ```/etc/origin/master```

```privkey.pem``` - Private key
```chain.pem``` - CA cert
```cert.pem``` - Main Cert

```
cp cert.pem /etc/letsencrypt/archive/koz-certtest.redhatgov.io/cert1.pem
cp chain.pem /etc/letsencrypt/archive/koz-certtest.redhatgov.io/chain1.pem
cp fullchain.pem /etc/letsencrypt/archive/koz-certtest.redhatgov.io/fullchain1.pem

ansible-playbook /usr/share/ansible/openshift-ansible/playbooks/openshift-hosted/redeploy-router-certificates.yml
```

#### API

```fullchain.pem``` - Main cert + CA cert

```privkey.pem``` - Private key

```
cp fullchain.pem /etc/origin/master/named_certificates

/usr/local/bin/master-restart api
```

### Debugging

Getting human readable output.

```
$ openssl x509 -noout -text -in domain-crt.txt 
```

Checking a cert's signing chain.

```
$ openssl crl2pkcs7 -nocrl -certfile domain-crt-bundle.txt | openssl pkcs7 -print_certs -noout

subject=CN = koz-test.redhatgov.io

issuer=C = US, O = Let's Encrypt, CN = Let's Encrypt Authority X3

subject=C = US, O = Let's Encrypt, CN = Let's Encrypt Authority X3

issuer=O = Digital Signature Trust Co., CN = DST Root CA X3
```

#### Obtaining the cert from a running site.

```
echo | openssl s_client -showcerts -servername gnupg.org -connect gnupg.org:443 2>/dev/null | openssl x509 -inform pem -noout -text
```