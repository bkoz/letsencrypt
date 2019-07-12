#!/bin/bash
#
# Renew the letsencrypt certs on the OpenShift v3.11.43 master and router.
#
# This script will only renew the certs. See the manual steps below update the 
# OpenShift API server and router with the new certs. 
# 

#
# This is based on Jared's certbot ansible role.
# https://raw.githubusercontent.com/jaredhocutt/openshift-provision/master/playbooks/roles/install_openshift/tasks/certs.yml
#

#
# =>: Backup /etc/letsencrypt before running this script.
# =>: Backup /etc/origin before running this script.
#
# =>: Export the following env vars before running this script.
#
# export AWS_ACCESS_KEY_ID= 
# export AWS_SECRET_ACCESS_KEY= 
#

#
# Edit the following to reflect your cluster
#
openshift_public_hostname="koz-certtest.redhatgov.io"
openshift_subdomain="*.apps.koz-certtest.redhatgov.io"
cert_email_address="bkozdemba@gmail.com"

<<<<<<< HEAD
# For an upgrade, these dirs should already exist.
=======
# For a cert renewal, these dirs should already exist. However, the ACLs will need to be correct (see below).
>>>>>>> 387eaa6474c609b4bc2729fe569cffafb7cda1d3
# mkdir /etc/letsencrypt
# chmod -R 555 /etc/letsencrypt

echo "Variables"
echo 
echo "AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID"
echo "AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY"
echo
echo "cert_email_address=$cert_email_address"
echo 
echo "Generating a single cert for the following domains:"
echo
echo "openshift_public_hostname=$openshift_public_hostname"
echo "openshift_subdomain=$openshift_subdomain"
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
# Updating OpenShift with the new certs. This should be an ansible playbook.
#

#
# Public API
#
# Refer to https://access.redhat.com/articles/3345491#masterapipublicredeploy
#
# To restart the API server:
# # /usr/local/bin/master-restart api (it should return a 2)
#
# The master may have to have it's OS rebooted if the API services won't successfully restart.

#
# Router
#

# Refer to https://access.redhat.com/articles/3345491

# As root, set the correct ACLs so the ec2-user can read the certs.
# # setfacl -R -m u:ec2-user:rx /etc/letsencrypt

# As the ec2-user, run this playbook.
# $ ansible-playbook playbooks/openshift-hosted/redeploy-router-certificates.yml

# Debugging router certs and gathering master logs
# https://access.redhat.com/articles/3183181
# https://access.redhat.com/articles/3663751

# Bugs
# https://access.redhat.com/solutions/3998521
# https://access.redhat.com/solutions/3488911
