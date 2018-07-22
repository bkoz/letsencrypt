#!/bin/bash
#
# LetsEncrypt testing.
#
docker run -it --rm --name certbot docker.io/certbot/certbot certonly --email bkozdemba@gmail.com -d presto.eadgbe.net --standalone --agree-tos --dry-run