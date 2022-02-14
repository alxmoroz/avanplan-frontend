#  Copyright (c) 2022. Alexandr Moroz
from lib.L3_app.api.v1.auth import user_repo
from lib.L3_app.settings import settings
from lib.L1_domain.entities.users import User


# TODO: должен быть такой ВИ (сброс настроек) и соотв. репо для этого
def main():
    admin_user = user_repo.get_one(email=settings.TEST_ADMIN_EMAIL)
    if not admin_user:
        user_repo.create(
            User(
                email=settings.TEST_ADMIN_EMAIL,
                password=settings.TEST_ADMIN_PASSWORD,
                is_superuser=True,
            ),
        )
    print("Admin_user created")


if __name__ == "__main__":
    main()
