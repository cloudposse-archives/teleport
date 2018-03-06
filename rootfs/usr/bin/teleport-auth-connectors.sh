#!/bin/bash

gomplate -f /etc/teleport/templates/teleport-github-connector-template.yaml -o /etc/teleport/teleport-github-connector.yaml

until tctl create -f /etc/teleport/teleport-github-connector.yaml; do
    echo 'retrying teleport-github-connector...' && sleep 1;
done
