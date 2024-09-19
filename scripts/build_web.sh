#!/usr/bin/env bash

# Copyright (c) 2022. Alexandr Moroz

set -e
set -x

flutter clean

bash ./scripts/api_rebuild.sh
dart run intl_utils:generate
bash ./scripts/build_runner_build.sh

echo "BUILDING FOR WEB..."
flutter build web --wasm
echo "BUILDING FOR WEB COMPLETE"