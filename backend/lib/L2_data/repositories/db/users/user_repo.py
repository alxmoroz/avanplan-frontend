#  Copyright (c) 2022. Alexandr Moroz

from sqlalchemy.orm import Session

from lib.L2_data.models import User as UserModel

from ..db_repo import DBRepo


class UserRepo(DBRepo[UserModel]):
    def __init__(self, db: Session):
        super().__init__(model_cls=UserModel, db=db)
