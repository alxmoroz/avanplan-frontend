#!/usr/bin/env bash

# Copyright (c) 2022. Alexandr Moroz

echo "DEPLOYING WEB..."

cp -r "./build/web/*" "/var/www/gercules/"

echo "DEPLOYING WEB COMPLETE"
