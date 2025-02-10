#!/usr/bin/env bash

# Copyright (c) 2022. Alexandr Moroz

cd "./openapi" || exit

# flutter pub get
dart run build_runner build -d
dart format ./**/*.dart

cd ../


