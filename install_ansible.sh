#!/bin/bash

PG_PASS=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-32};echo;)
ADMIN_PASS=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-32};echo;)
RABBIT_PASS=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-32};echo;)
SETUP_BUNDLE="ansible-tower-setup-bundle-latest.el7.tar.gz"
IP_ADDRESS=$(grep Vagrant /etc/sysconfig/network-scripts/ifcfg-* | awk -F':' '{print $1}' | xargs awk -F'=' '/IPADDR/ {print $2}')

cd /root
yum install wget -y
wget -q https://releases.ansible.com/ansible-tower/setup-bundle/$SETUP_BUNDLE
FOLDER=$(tar tf $SETUP_BUNDLE | awk -F'/' '{print $1;exit}')
tar xf $SETUP_BUNDLE
cd $FOLDER

sed -i "s/^admin_password.*/admin_password='$ADMIN_PASS'/g" inventory
sed -i "s/^pg_password.*/pg_password='$PG_PASS'/g" inventory
sed -i "s/^rabbitmq_password.*/rabbitmq_password='$RABBIT_PASS'/g" inventory

./setup.sh

cat << EOF > /etc/motd
Welcome to your test Ansible Tower Server.

The website should be accessible via:
https://$IP_ADDRESS

The admin password is:
$ADMIN_PASS
EOF
