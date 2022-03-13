#  Copyright (c) 2022. Alexandr Moroz

from fastapi.encoders import jsonable_encoder
from sqlalchemy.orm import Session

from lib.L2_data.schema import UserSchemaUpsert
from lib.L2_data.repositories.db import UserRepo
from lib.L2_data.db import DBSession
from lib.L2_data.settings import settings


# TODO: должен быть такой ВИ (сброс настроек) и соотв. репо для этого
def main():
    db: Session = DBSession()
    user_repo = UserRepo(db)
    admin_user = user_repo.get_one(email=settings.TEST_ADMIN_EMAIL)
    if not admin_user:
        s = (
            UserSchemaUpsert(
                email=settings.TEST_ADMIN_EMAIL,
                password=settings.TEST_ADMIN_PASSWORD,
                is_superuser=True,
            ),
        )

        user_repo.upsert(**jsonable_encoder(s))
        print("Admin_user created")

    db.close()


if __name__ == "__main__":
    main()
