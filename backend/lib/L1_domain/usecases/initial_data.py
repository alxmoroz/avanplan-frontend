#  Copyright (c) 2022. Alexandr Moroz

from lib.L1_domain.entities.auth import CreateUser
from lib.L2_app.extra.config import settings
from lib.L3_data.repositories import user_repo
from lib.L3_data.repositories.db_repo import SessionLocal

# TODO: должен быть такой ВИ (сброс настроек) и соотв. репо для этого


def main() -> None:

    db = SessionLocal()
    user_db = user_repo.get_by_email(db, email=settings.FIRST_SUPERUSER_EMAIL)
    if not user_db:
        user_repo.create(
            db,
            obj_in=CreateUser(
                email=settings.FIRST_SUPERUSER_EMAIL,
                password=settings.FIRST_SUPERUSER_PASSWORD,
                is_superuser=True,
            ),
        )
    print("Initial data created")


if __name__ == "__main__":
    main()
