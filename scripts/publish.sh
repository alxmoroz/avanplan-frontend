#!/usr/bin/env bash

# Copyright (c) 2022. Alexandr Moroz

set -e
set -x

flutter clean

bash ./scripts/api_generate.sh
bash ./scripts/bump_version.sh
bash ./scripts/build_runner_clean.sh
flutter pub run intl_utils:generate
bash ./scripts/build_runner_build.sh
#bash ./scripts/test.sh || exit
#bash ./scripts/build_android.sh
#bash ./scripts/build_ios.sh
bash ./scripts/build_web.sh
bash ./scripts/deploy_web.sh
