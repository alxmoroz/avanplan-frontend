#!/usr/bin/env bash

#
# Copyright (c) 2022. Alexandr Moroz
#

export PYTHONPATH="."

pip3 install -r ./scripts/reqs.txt

bash ./scripts/migrate.sh
python3 ./scripts/initial_data.py
