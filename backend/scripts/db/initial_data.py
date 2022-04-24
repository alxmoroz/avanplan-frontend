#  Copyright (c) 2022. Alexandr Moroz

from fastapi.encoders import jsonable_encoder
from sqlalchemy.orm import Session

from lib.L2_data.schema import RemoteTrackerTypeSchemaUpsert, UserSchemaUpsert
from lib.L2_data.repositories.db import UserRepo, RemoteTrackerTypeRepo
from lib.L2_data.db import db_session
from tests.conf_user import DEFAULT_ADMIN_EMAIL, TEST_ADMIN_PASSWORD


# TODO: должен быть такой ВИ (сброс настроек) и соотв. репо для этого
def main():
    db_auth: Session = db_session("auth")
    user_repo = UserRepo(db_auth)
    admin_user = user_repo.get_one(email=DEFAULT_ADMIN_EMAIL)
    if not admin_user:
        s = UserSchemaUpsert(
            email=DEFAULT_ADMIN_EMAIL,
            password=TEST_ADMIN_PASSWORD,
            is_superuser=True,
        )

        user_repo.upsert(jsonable_encoder(s))
        print("Admin_user created")

    ttype_repo = RemoteTrackerTypeRepo(db_auth)
    for code in ["Redmine"]:
        type_in_db = ttype_repo.get_one(title=code)
        if not type_in_db:
            ttype_repo.upsert(jsonable_encoder(RemoteTrackerTypeSchemaUpsert(title=code)))
    print("Remote Tracker types created")

    db_auth.close()


if __name__ == "__main__":
    main()
