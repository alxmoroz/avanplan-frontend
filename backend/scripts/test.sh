#!/usr/bin/env bash

set -e
set -x

pytest --cov=lib --cov-report=term-missing lib/tests "${@}"
