# letsencrypt
Set up a letsencrypt certbot

Checking a cert's signing chain.

```
openssl crl2pkcs7 -nocrl -certfile /etc/letsencrypt/live/reg.koz.redhatgov.io/fullchain.pem | openssl pkcs7 -print_certs -noout
```
