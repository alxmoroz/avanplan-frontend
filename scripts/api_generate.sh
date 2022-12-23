#!/usr/bin/env bash

# Copyright (c) 2022. Alexandr Moroz

#remote_schema="http://localhost:8000/v1/openapi.json"
remote_schema="https://avanplan.ru/api/v1/openapi.json"
api_folder="./openapi"

fullDir="${PWD}/${api_folder}"
rm -rf "$fullDir"
mkdir "$fullDir"

echo "Generate client service from $remote_schema"
cd "$api_folder" || exit
curl -L $remote_schema > openapi.json
openapi-generator-cli generate -i openapi.json -g dart-dio -o .

#flutter pub get
bash ../scripts/build_runner_clean.sh
bash ../scripts/build_runner_build.sh
flutter format ./**/*.dart

cd ../
