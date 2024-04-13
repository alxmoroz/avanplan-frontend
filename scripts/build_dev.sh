#!/usr/bin/env bash

# Copyright (c) 2022. Alexandr Moroz

set -e
set -x

bash ./scripts/api_rebuild.sh
bash ./scripts/build_runner_watch.sh
