#  Copyright (c) 2022. Alexandr Moroz

from sqlalchemy.orm import Session

from lib.L2_data.models import User as UserModel
from lib.L2_data.repositories import entities as er

from ..db_repo import DBRepo


class UserRepo(DBRepo):
    def __init__(self, db: Session):
        super().__init__(
            model_cls=UserModel,
            entity_repo=er.UserRepo(),
            db=db,
        )
