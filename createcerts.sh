#!/bin/bash
#
# Based on Jared's certbot ansaibler role.
# https://raw.githubusercontent.com/jaredhocutt/openshift-provision/master/playbooks/roles/install_openshift/tasks/certs.yml
#

openshift_public_hostname="openshift.koz.redhat.gov.io"
openshift_subdomain="*.apps.koz.redhatgov.io"
cert_email_address="bkozdemba@gmail.com"
reg_public_hostname="reg.koz.redhatgov.io"

mkdir /etc/letsencrypt
chmod -R 555 /etc/letsencrypt
chown -R ec2-user:ec2-user /etc/letsencrypt

echo "Variables"
echo "AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID"
echo "AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY"
echo "cert_email_address=$cert_email_address"
echo "openshift_public_hostname=$openshift_public_hostname"
echo "openshift_subdomain=$openshift_subdomain"
echo "reg_public_hostname=$reg_public_hostname"

#path: "/etc/letsencrypt"
#    entity: "{{ ansible_user }}"
#    etype: user
#    permissions: rx
#    recursive: yes
#    follow: yes
#    state: present


echo "Genrating cert for OCP api"

docker run --rm --name certbot \
    -v "/etc/letsencrypt:/etc/letsencrypt:z" \
    -v "/var/lib/letsencrypt:/var/lib/letsencrypt:z" \
    -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
    -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
    certbot/dns-route53 certonly \
    --non-interactive \
    --agree-tos \
    --email $cert_email_address \
    --dns-route53 \
    --dns-route53-propagation-seconds 30 \
    --domain $openshift_public_hostname

# creates: /etc/letsencrypt/live/{{ openshift_public_hostname }}

echo "Genrating wildcard cert for OCP router"

docker run --rm --name certbot \
    -v "/etc/letsencrypt:/etc/letsencrypt:z" \
    -v "/var/lib/letsencrypt:/var/lib/letsencrypt:z" \
    -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
    -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
    certbot/dns-route53 certonly \
    --non-interactive \
    --agree-tos \
    --email $cert_email_address \
    --dns-route53 \
    --dns-route53-propagation-seconds 30 \
    --server https://acme-v02.api.letsencrypt.org/directory \
    --domain "$openshift_subdomain" 

#    creates: /etc/letsencrypt/live/apps.{{ openshift_public_hostname }}

echo "Genrating cert for $reg_public_hostname"

docker run --rm --name certbot \
    -v "/etc/letsencrypt:/etc/letsencrypt:z" \
    -v "/var/lib/letsencrypt:/var/lib/letsencrypt:z" \
    -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
    -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
    certbot/dns-route53 certonly \
    --non-interactive \
    --agree-tos \
    --email $cert_email_address \
    --dns-route53 \
    --dns-route53-propagation-seconds 30 \
    --domain $reg_public_hostname
