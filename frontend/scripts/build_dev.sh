#!/usr/bin/env bash

# Copyright (c) 2022. Alexandr Moroz

bash ./scripts/api_generate.sh
bash ./scripts/build_runner_clean.sh
bash ./scripts/build_runner_watch.sh
