#!/usr/bin/env bash

#
# Copyright (c) 2022. Alexandr Moroz
#

bash ./scripts/migrate.sh
python3 -m ./scripts/initial_data.py
