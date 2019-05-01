# letsencrypt

## Notes

The ```letsencrypt``` util and [zerossl](https://zerossl.com/) web site generate the following files:

account-key.txt - Account key

domain-key.txt - Private key or ```privkey.pem```.

domain-crt.txt - A bundle that contains the cert followed by the CA. This should be broken apart
into separate certs (main cert and CA) with a text editor. Also called ```fullchain.pem```. 

domain-csr.txt - Cert signing request (keep for renewal).

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
