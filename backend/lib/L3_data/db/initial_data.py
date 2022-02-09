#  Copyright (c) 2022. Alexandr Moroz

import logging

from sqlalchemy.orm import Session

from lib.L1_domain.entities.auth import CreateUser
from lib.L2_app.extra.config import settings
from lib.L3_data.db.session import SessionLocal
from lib.L3_data.repositories import user_repo

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


# make sure all SQL Alchemy models are imported (db.base) before initializing DB
# otherwise, SQL Alchemy might fail to initialize relationships properly
# for more details: https://github.com/tiangolo/full-stack-fastapi-postgresql/issues/28


# TODO: должен быть такой ВИ (сброс настроек) и соотв. репо для этого
def init_db(db: Session) -> None:

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


def main() -> None:
    logger.info("Creating initial data")
    db = SessionLocal()
    init_db(db)
    logger.info("Initial data created")


if __name__ == "__main__":
    main()
