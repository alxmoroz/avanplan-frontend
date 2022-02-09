#!/usr/bin/env bash

#
# Copyright (c) 2022. Alexandr Moroz
#

set -x

autoflake --remove-all-unused-imports --recursive --remove-unused-variables --in-place lib --exclude=__init__.py
black lib
isort lib
flake8 lib
