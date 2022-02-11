#  Copyright (c) 2022. Alexandr Moroz
from typing import Type

from lib.L1_domain.entities.users import User

from ..models.users import User as UserModel
from .db_repo import DBRepo
from .security_repo import SecurityRepo

# TODO: нужен соотв. репозиторий в Л1


class UserDBRepo(DBRepo[UserModel, User]):
    def __init__(self, model: Type[UserModel], entity: Type[User] = User):

        super().__init__(model, entity)

    def get_by_email(self, email: str) -> User | None:
        users = self.get(dict(email=email))
        return users[0] if len(users) > 0 else None

    def create(self, e: User) -> User:
        e.password = SecurityRepo().get_hashed_password(e.password)
        return super().create(e)

    def update(self, e: User) -> int:
        # TODO: в юзкейс перенести?
        e.password = SecurityRepo().get_hashed_password(e.password)
        return super().update(e)
