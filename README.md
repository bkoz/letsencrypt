# letsencrypt

## Notes on installing and replacing letsencrypt certs on OpenShift.

The ```letsencrypt``` util and [zerossl](https://zerossl.com/) web site generate the following files:

account-key.txt - Account key

domain-key.txt - Private key or ```privkey.pem```.

domain-crt.txt - A bundle that contains the cert followed by the CA. This should be broken apart
into separate certs (main cert and CA) with a text editor. Also called ```fullchain.pem```. 

domain-csr.txt - Cert signing request (keep for renewal).

### zerossl

This online tool is useful when the letsencrypt util will not renew because it is too early.

Copy/paste CSR from /etc/letsencrypt/csr/0000_csr-certbot.pem into web site

Create TXT records in Route53

Allow 5 minutes or so to let the records propagate.

Test the TXT records

```
$ host -t TXT _acme-challenge.koz-certtest.redhatgov.io
_acme-challenge.koz-certtest.redhatgov.io descriptive text "ZepiokcmBUXZuiwV67hH54hPxhYWiw8677BuL5CfwJI"

$ host -t TXT _acme-challenge.koz-certtest.redhatgov.io
_acme-challenge.koz-certtest.redhatgov.io descriptive text "ZepiokcmBUXZuiwV67hH54hPxhYWiw8677BuL5CfwJI"
```

Copy the cert into fullchain.txt

Edit this file and split out the cert and CA into separate files.

```account-key.txt``` - Account key

```domain-key.txt``` - Private key or ```privkey.pem```.

```domain-crt.txt``` - Also called ```fullchain.pem```. A bundle that contains the cert followed by the CA. This should be broken apart into separate certs (main cert.pem and chain.pem (CA cert)) with a text editor. 

```domain-csr.txt``` - Cert signing request (keep for renewal).

### letsencrypt binary output

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
