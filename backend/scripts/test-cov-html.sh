#!/usr/bin/env bash

#
# Copyright (c) 2022. Alexandr Moroz
#

set -e
set -x

bash scripts/test.sh --cov-report=html "${@}"
