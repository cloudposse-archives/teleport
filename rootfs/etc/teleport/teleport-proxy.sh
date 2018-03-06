#!/bin/bash

gomplate -f /etc/teleport/teleport-proxy.yaml

teleport start --config=/etc/teleport/teleport-proxy.yaml --insecure-no-tls --roles=proxy
