#  Copyright (c) 2022. Alexandr Moroz

import psycopg2
import os

from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT

from lib.L2_data.db import db_user_from_org, db_name_from_org, db_password_from_org

org_name = os.getenv("H_ORG_NAME")

db_user = db_user_from_org(org_name)
db_name = db_name_from_org(org_name)
db_password = db_password_from_org(org_name)

try:
    conn = psycopg2.connect(dbname="postgres", user="postgres", host="localhost", password="postgres")
    conn.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)
    cur = conn.cursor()
    queryset_list = [
        f"drop database {db_name};",
        f"drop user {db_user};",
        f"create user {db_user} password '{db_password}';",
        f"create database {db_name} with owner='{db_user}' encoding='utf-8' lc_collate='C' lc_ctype='C' template template0;",
    ]
    for query in queryset_list:
        try:
            cur.execute(query)
            print(query)
        except Exception as error:
            print(error)

except Exception as error:
    print(f"Проблема подключения к БД {error}")
