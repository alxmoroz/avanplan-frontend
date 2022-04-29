#!/usr/bin/env bash

#
# Copyright (c) 2022. Alexandr Moroz
#

set -e
#set -x

export PYTHONPATH="."
export DB_NAME="hercules"
export ADMIN_EMAIL=$1

python3 ./scripts/db/init_workspace.py || exit
