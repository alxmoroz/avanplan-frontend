#!/usr/bin/env bash

set -x

black lib --check
isort --recursive --check-only lib
flake8
