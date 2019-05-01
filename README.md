# letsencrypt

## Notes

letsencrypt generates the following files:

account-key.txt - Account key

domain-key.txt - Private key 

domain-crt.txt - A bundle that contains the cert followed by the CA. This should be broken apart
into separate certs (main cert and CA) with a text editor. 

domain-csr.txt - Cert signing request (keep for renewal)

Human readable output example.

```
$ openssl x509 -noout -text -in domain-crt.txt 
```

Checking a cert's signing chain.

```
openssl crl2pkcs7 -nocrl -certfile /etc/letsencrypt/live/reg.koz.redhatgov.io/fullchain.pem | openssl pkcs7 -print_certs -noout
```
