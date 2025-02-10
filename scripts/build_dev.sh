#!/usr/bin/env bash

# Copyright (c) 2022. Alexandr Moroz

set -e
set -x

bash ./scripts/api_rebuild.sh
dart run build_runner watch -d
