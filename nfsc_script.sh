#!/bin/bash

yum -y install nfs-utils
mkdir /mnt/upload
systemctl enable rpcbind
systemctl start rpcbind

mount -t nfs -o proto=udp,vers=3  192.168.50.10:/mnt/upload /mnt/upload

echo "192.168.50.10:/mnt/upload /mnt/upload nfs rw,vers=3,sync,proto=udp,rsize=32768,wsize=32768 0" >>/etc/fstab

touch /etc/systemd/system/mnt-upload.mount
echo "[Unit]
Description=NFS share
Requires=network-online.service
After=network-online.serviсe
[Mount]
What=192.168.50.10:/mnt/upload
Where=/mnt/upload
Type=nfs
Options=rw,proto=udp,vers=3
[Install]
WantedBy=multi-user.target" >> /etc/systemd/system/mnt-upload.mount

systemctl daemon-reload
systemctl enable mnt-upload.mount
systemctl start mnt-upload.mount
