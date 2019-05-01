#!/bin/bash
#
# Based on Jared's certbot ansible role.
# https://raw.githubusercontent.com/jaredhocutt/openshift-provision/master/playbooks/roles/install_openshift/tasks/certs.yml
#
#
# =>: Backup /etc/letsencrypt before running this script.
#
# =>: Export the following env vars before running this script.
#
# export AWS_ACCESS_KEY_ID= 
# export AWS_SECRET_ACCESS_KEY= 
#

openshift_public_hostname="koz-nash.redhatgov.io"
openshift_subdomain="*.apps.koz-nash.redhatgov.io"
cert_email_address="bkozdemba@gmail.com"

mkdir /etc/letsencrypt
chmod -R 555 /etc/letsencrypt

echo "Variables"
echo 
echo "AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID"
echo "AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY"
echo "cert_email_address=$cert_email_address"
echo "openshift_public_hostname=$openshift_public_hostname"
echo "openshift_subdomain=$openshift_subdomain"
echo
echo "Generating a single cert w/multiple domains..."
echo

docker run --rm --name certbot\
    -v "/etc/letsencrypt:/etc/letsencrypt:z"\
    -v "/var/lib/letsencrypt:/var/lib/letsencrypt:z"\
    -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
    -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
    certbot/dns-route53 certonly\
    --non-interactive\
    --agree-tos\
    --email $cert_email_address \
    --dns-route53\
    --dns-route53-propagation-seconds 45\
    --server https://acme-v02.api.letsencrypt.org/directory\
    --domain $openshift_public_hostname \
    --domain $openshift_subdomain

#
# Updating OpenShift with the new certs.
#

# See [this doc](https://docs.openshift.com/container-platform/3.11/install_config/certificate_customization.html)
# for how to manually update public API certs and router 
# certs.


# KB Articles
# https://access.redhat.com/articles/3345491

# Router
# ansible-playbook playbooks/openshift-hosted/redeploy-router-certificates.yml

# Web console

# Bugs
# https://access.redhat.com/solutions/3998521
# https://access.redhat.com/solutions/3488911


