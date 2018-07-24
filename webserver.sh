#!/bin/bash
#
# LetsEncrypt testing.
#
# https://www.tenormanmike.com/website-and-hosting-issues/how-to-install-a-lets-encrypt-ssl-on-a-shared-godaddy-hosting-account/
#
# Easy way to create a cert for an existing web server (--manual) using ZeroSSL's web interface.
# To renew, copy and paste in the CSR.
# https://zerossl.com/

# https://certbot.eff.org/docs/using.html#plugins

# Manual method from a docker container. It will geneate the challenge key and filename that you need to 
# put into a working web server's directory. The certs are created in the container so the /etc/letsencrypt directory must
# be copied or host mounted to save the certs.

docker run -it --rm --name certbot docker.io/certbot/certbot certonly --manual --preferred-challenges http --email bkozdemba@gmail.com -d presto.eadgbe.net --agree-tos --dry-run

# Renewal - This will command will examine /etc/letsencrypt on the host for exsiting certs and renew ones that are aproaching expiration.
docker run -it --rm --name certbot -v /etc/letsencrypt:/etc/letsencrypt docker.io/certbot/certbot renew

