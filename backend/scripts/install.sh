#!/usr/bin/env bash

#
# Copyright (c) 2022. Alexandr Moroz
#

set -e
set -x

export PYTHONPATH="."
export DB_NAME="hercules"

pip3 install -r ./scripts/reqs.txt

python3 ./scripts/db/clean_db.py || exit
bash ./scripts/db/migrate.sh "$DB_NAME" || exit
python3 ./scripts/db/init_data.py || exit

# service
cp ./scripts/hercules.service /etc/systemd/system || exit
systemctl daemon-reload || exit
systemctl start hercules || exit
systemctl enable hercules || exit
