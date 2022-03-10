#  Copyright (c) 2022. Alexandr Moroz

from sqlalchemy.orm import Session

from lib.L1_domain.entities import User
from lib.L2_data.models import User as UserModel
from lib.L2_data.schema import UserSchema

from ..db_repo import DBRepo


class UserRepo(DBRepo):
    def __init__(self, db: Session):
        super().__init__(UserModel, UserSchema, UserSchema, User, db)
