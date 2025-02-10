#!/usr/bin/env bash

# Copyright (c) 2022. Alexandr Moroz

set -e
set -x

flutter clean

bash ./scripts/api_rebuild.sh
dart run intl_utils:generate
dart run build_runner build -d

echo "BUILDING FOR WEB..."
flutter build web
echo "BUILDING FOR WEB COMPLETE"