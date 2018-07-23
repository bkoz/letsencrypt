#!/bin/bash
#
# LetsEncrypt testing.
#
docker run -it --rm --name certbot docker.io/certbot/certbot certonly --email bkozdemba@gmail.com -d presto.eadgbe.net --standalone --agree-tos --dry-run

#
# https://www.tenormanmike.com/website-and-hosting-issues/how-to-install-a-lets-encrypt-ssl-on-a-shared-godaddy-hosting-account/
#
# Easy way to create a cert for an existing web server.
# To renew, copy and paste in the CSR.
# https://zerossl.com/