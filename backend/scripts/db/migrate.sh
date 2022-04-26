#!/usr/bin/env bash

#
# Copyright (c) 2022. Alexandr Moroz
#

export PYTHONPATH="."

export DB_NAME=$1
alembic -c ./scripts/db/alembic/alembic.ini revision --autogenerate
alembic -c ./scripts/db/alembic/alembic.ini upgrade head
