#!/usr/bin/env bash

# Copyright (c) 2022. Alexandr Moroz

echo "build_runner clean..."

flutter pub get
dart run build_runner clean

echo "build_runner clean complete"
