#  Copyright (c) 2022. Alexandr Moroz

# from sqlalchemy.orm import Session

from lib.L1_domain.entities.users import User
from lib.L2_data.models.users import User as UserModel
from lib.L2_data.repositories import DBRepo, SecurityRepo


class UserRepo(DBRepo[UserModel, User]):
    pass


# def get_user_repo(db: Session) -> UserRepo:
#     return UserRepo(UserModel, User, db)


user_repo = DBRepo(UserModel, User)

security_repo = SecurityRepo()
