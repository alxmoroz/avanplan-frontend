#!/usr/bin/env bash

#
# Copyright (c) 2022. Alexandr Moroz
#

export PYTHONPATH="."

# Let the DB start
python3 ./scripts/backend_pre_start.py

# Run migrations
alembic -c ./lib/L3_data/alembic/alembic.ini upgrade head

# Create initial data in DB
python3 ./lib/L3_data/initial_data.py
