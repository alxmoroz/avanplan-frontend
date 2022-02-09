#!/usr/bin/env bash

#
# Copyright (c) 2022. Alexandr Moroz
#

set -e
set -x

pytest --cov=lib --cov-report=html lib/tests
