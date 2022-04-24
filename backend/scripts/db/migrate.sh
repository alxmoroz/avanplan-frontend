#!/usr/bin/env bash

#
# Copyright (c) 2022. Alexandr Moroz
#

export PYTHONPATH="."

export H_ORG_NAME="auth"
alembic -c ./scripts/db/alembic_auth/alembic.ini revision --autogenerate
alembic -c ./scripts/db/alembic_auth/alembic.ini upgrade head

export H_ORG_NAME=$1
alembic -c ./scripts/db/alembic_data/alembic.ini revision --autogenerate
alembic -c ./scripts/db/alembic_data/alembic.ini upgrade head
