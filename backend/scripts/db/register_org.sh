#!/usr/bin/env bash

#
# Copyright (c) 2022. Alexandr Moroz
#

export PYTHONPATH="."

export H_ORG_NAME=$1
python3 ./scripts/db/clean_db.py

bash ./scripts/db/migrate.sh "$1"
python3 ./scripts/db/init_data.py