# letsencrypt

## Notes

The ```letsencrypt``` util and [zerossl](https://zerossl.com/) web site generate the following files:

### zerossl

account-key.txt - Account key

domain-key.txt - Private key or ```privkey.pem```.

domain-crt.txt - Also called ```fullchain.pem```. A bundle that contains the cert followed by the CA. This should be broken apartvinto separate certs (main cert.pem and chain.pem (CA cert)) with a text editor. 

domain-csr.txt - Cert signing request (keep for renewal).

### letsencrypt binary output

privkey.pem - Private key

chain.pem - CA cert

cert.pem - Main Cert

fullchain.pem - Main + CA cert combo

### OpenShift

#### Router

/etc/origin/master

privkey.pem - Private key

chain.pem - CA cert

cert.pem - Main Cert

#### API

/etc/origin/master/named_certificates

fullchain.pem - Main cert + CA cert

privkey.pem   - Private key


### Debugging

Human readable output example.

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
