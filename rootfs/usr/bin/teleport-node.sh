#!/bin/bash

cp /usr/local/bin/teleport /host/usr/local/bin/teleport
cp /etc/systemd/system/teleport-node.service /host/etc/systemd/system/teleport-node.service

gomplate -f /etc/teleport/templates/teleport-node-template.yaml -o /etc/teleport/teleport-node.yaml

chroot /host rm -rf /var/lib/teleport
chroot /host systemctl daemon-reload
chroot /host systemctl restart teleport-node.service

sleep inf
