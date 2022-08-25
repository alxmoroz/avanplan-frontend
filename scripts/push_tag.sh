#!/usr/bin/env bash

# Copyright (c) 2022. Alexandr Moroz

bash ./scripts/bump_version.sh

version=$(grep 'version: ' pubspec.yaml | sed "s/^[^0-9]*\(.*[.]\).*/\1$build_number/")
git commit -m "Bump version to $version" pubspec.yaml

git tag "$version"
git push

echo "Bump version to $version to git"