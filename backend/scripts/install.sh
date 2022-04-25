#!/usr/bin/env bash

#
# Copyright (c) 2022. Alexandr Moroz
#

export PYTHONPATH="."

pip3 install -r ./scripts/reqs.txt

python3 ./scripts/db/register_org.py test

# service
cp ./scripts/hercules.service /etc/systemd/system
systemctl daemon-reload
systemctl start hercules
systemctl enable hercules
