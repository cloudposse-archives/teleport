#!/bin/bash

gomplate -f /etc/teleport/templates/teleport-auth-template.yaml -o /etc/teleport/teleport-auth.yaml

teleport start --config=/etc/teleport/teleport-auth.yaml --roles=auth
