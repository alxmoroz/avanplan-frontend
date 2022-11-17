#!/usr/bin/env bash

# Copyright (c) 2022. Alexandr Moroz

echo "BUILDING FOR WEB..."

flutter build web -t lib/L3_app/main.dart --web-renderer html

echo "BUILDING FOR WEB COMPLETE"
