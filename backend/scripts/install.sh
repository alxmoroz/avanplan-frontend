#!/usr/bin/env bash

#
# Copyright (c) 2022. Alexandr Moroz
#

export PYTHONPATH="."

pip3 install -r ./scripts/reqs.txt

bash ./scripts/db/register_org.sh test

# service
cp ./scripts/hercules.service /etc/systemd/system
systemctl daemon-reload
systemctl start hercules
systemctl enable hercules
