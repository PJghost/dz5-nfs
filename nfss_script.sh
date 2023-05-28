#!/bin/bash

yum -y install nfs-utils
mkdir /srv/upload
chmod -R 0777 /srv/upload
echo "/srv/upload 192.168.50.0/24(rw,sync,no_root_squash,no_all_squash)" > /etc/exports
exportfs -r
systemctl start firewalld
firewall-cmd --permanent --add-service=rpc-bind
firewall-cmd --permanent --add-service=mountd
firewall-cmd --permanent --add-port=2049/tcp
firewall-cmd --permanent --add-port=2049/udp
firewall-cmd --reload
systemctl enable rpcbind nfs-server
systemctl start rpcbind nfs-server
