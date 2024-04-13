#!/usr/bin/env bash

# Copyright (c) 2022. Alexandr Moroz

cd "./openapi" || exit

# flutter pub get
bash ../scripts/build_runner_build.sh
dart format ./**/*.dart

cd ../


