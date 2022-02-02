#!/usr/bin/env bash

set -x

black lib --check
isort --check-only lib
flake8
