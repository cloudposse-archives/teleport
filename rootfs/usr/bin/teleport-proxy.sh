#!/bin/bash

gomplate -f /etc/teleport/templates/teleport-proxy-template.yaml -o /etc/teleport/teleport-proxy.yaml

teleport start --config=/etc/teleport/teleport-proxy.yaml --insecure-no-tls --roles=proxy
