#!/usr/bin/env bash

# Copyright (c) 2022. Alexandr Moroz

set -e
set -x

echo "DEPLOYING WEB..."
cp -r ./build/web/* /var/www/avanplan/
echo "DEPLOYING WEB COMPLETE"
