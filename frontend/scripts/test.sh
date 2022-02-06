#!/usr/bin/env bash

# Copyright (c) 2022. Alexandr Moroz

flutter test --coverage

# отчет о покрытии
# genhtml coverage/lcov.info -o coverage/html > /dev/null
