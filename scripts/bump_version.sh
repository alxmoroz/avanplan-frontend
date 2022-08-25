#!/usr/bin/env bash

# Copyright (c) 2022. Alexandr Moroz

build_number=$(git rev-list --all | wc -l | xargs)
sed -i.bak "s/^\(version:.*[.]\).*$/\1$build_number+$build_number/" pubspec.yaml