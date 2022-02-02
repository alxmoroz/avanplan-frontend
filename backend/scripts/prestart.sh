#! /usr/bin/env bash

# Let the DB start
python /lib/L3_data/backend_pre_start.py

# Run migrations
alembic upgrade head

# Create initial data in DB
python /lib/L3_data/initial_data.py
