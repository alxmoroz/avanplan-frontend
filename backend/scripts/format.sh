#!/bin/sh -e
set -x

autoflake --remove-all-unused-imports --recursive --remove-unused-variables --in-place lib --exclude=__init__.py
black lib
isort lib
