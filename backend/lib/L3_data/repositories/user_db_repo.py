#  Copyright (c) 2022. Alexandr Moroz

from lib.L1_domain.entities.users import User

from ..models.users import User as UserModel
from .db_repo import DBRepo
from .security_repo import SecurityRepo


class UserDBRepo(DBRepo[UserModel, User]):
    def create(self, e: User) -> User:
        e.password = SecurityRepo().get_hashed_password(e.password)
        return super().create(e)

    def update(self, e: User) -> int:
        # TODO: в юзкейс перенести?
        e.password = SecurityRepo().get_hashed_password(e.password)
        return super().update(e)
