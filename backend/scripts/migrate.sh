#!/usr/bin/env bash

#
# Copyright (c) 2022. Alexandr Moroz
#

export PYTHONPATH="."

# Run migrations
alembic -c ./lib/L2_data/alembic/alembic.ini revision --autogenerate
alembic -c ./lib/L2_data/alembic/alembic.ini upgrade head
