#!/usr/bin/env bash

#
# Copyright (c) 2022. Alexandr Moroz
#

export PYTHONPATH="."

bash ./scripts/migrate.sh
python3 ./lib/L3_data/initial_data.py
