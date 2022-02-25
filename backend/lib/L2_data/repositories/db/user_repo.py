#  Copyright (c) 2022. Alexandr Moroz

from sqlalchemy.orm import Session

from lib.L1_domain.entities.users import User
from lib.L2_data.models import User as UserModel
from lib.L2_data.repositories import DBRepo


class UserRepo(DBRepo[UserModel, User]):
    def __init__(self, db: Session):
        super().__init__(UserModel, User, db)
