#!/bin/bash

gomplate -f /etc/teleport/teleport-auth.yaml
gomplate -f /etc/teleport/teleport-github-connector.yaml

teleport start --config=/etc/teleport/teleport-auth.yaml --roles=auth

sleep 3

until
    tctl create -f /etc/teleport/teleport-github-connector.yaml; do echo 'retrying teleport-github-connector...' && sleep 1;
done
