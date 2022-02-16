#  Copyright (c) 2022. Alexandr Moroz

from sqlalchemy.orm import Session

from lib.L1_domain.entities.users import User
from ..models.users import User as UserModel
from ..repositories import DBRepo


class UserRepo(DBRepo[UserModel, User]):
    def __init__(self, db: Session):
        super().__init__(UserModel, User, db)
