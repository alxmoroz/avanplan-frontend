#  Copyright (c) 2022. Alexandr Moroz

from lib.L1_domain.entities.users import CreateUser
from lib.L2_app.extra.config import settings
from lib.L3_data.repositories import user_repo

# TODO: должен быть такой ВИ (сброс настроек) и соотв. репо для этого


def main() -> None:

    user_db = user_repo.get_by_email(email=settings.FIRST_SUPERUSER_EMAIL)
    if not user_db:
        user_repo.create(
            obj_in=CreateUser(
                email=settings.FIRST_SUPERUSER_EMAIL,
                password=settings.FIRST_SUPERUSER_PASSWORD,
                is_superuser=True,
            ),
        )
    print("Initial data created")


if __name__ == "__main__":
    main()
