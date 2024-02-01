#!/usr/bin/env bash


export DEBIAN_FRONTEND=noninteractive
apt update
apt install -y postfix dovecot-core dovecot-pop3d


cp -R postfix /etc/postfix
cp -R dovecot /etc/dovecot

postmap /etc/postfix/sasl_password
echo 'nameserver 8.8.8.8' > /var/spool/postfix/etc/resolv.conf

read -s -p 'SASL Password: ' sasl
sed -i "s/CHANGEME_SENDGRID/$sasl/" /etc/postfix/sasl_password


systemctl restart postfix
systemctl restart dovecot
