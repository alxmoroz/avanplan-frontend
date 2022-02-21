#  Copyright (c) 2022. Alexandr Moroz

from ..entities.api.exceptions import ApiException
from ..entities.auth import TokenPayload
from ..entities.users import User
from ..repositories import AbstractDBRepo, AbstractSecurityRepo


class UsersUC:
    def __init__(self, user_repo: AbstractDBRepo, security_repo: AbstractSecurityRepo):
        self.user_repo = user_repo
        self.sec_repo = security_repo

    # TODO: очень связаны логически юзкейсы авторизации и этот

    def _get_auth_user(self) -> User:
        token_payload: TokenPayload = self.sec_repo.get_decoded_token_payload()
        # TODO: не хватает обработки протухшего токена
        user: User = self.user_repo.get_one(email=token_payload.identifier)
        if not user:
            raise ApiException(404, "User not found")
        return user

    def get_users(self, skip, limit) -> list[User]:
        self.get_active_superuser()

        return self.user_repo.get(skip=skip, limit=limit)

    # TODO: возможны проблемы с id, заполненным по ошибке
    def create_user(self, user: User) -> User:
        self.get_active_superuser()

        if self.user_repo.get_one(email=user.email):
            raise ApiException(400, "The user with this email already exists.")
        user.password = self.sec_repo.secure_password(user.password)
        return self.user_repo.create(user)

    def get_active_user(self) -> User:
        user = self._get_auth_user()

        if not user.is_active:
            raise ApiException(403, "Inactive user")
        return user

    def update_my_account(self, full_name: str, password: str) -> User:
        user = self.get_active_user()

        if password is not None:
            user.password = self.sec_repo.secure_password(password)
        if full_name is not None:
            user.full_name = full_name

        self.user_repo.update(user)
        return user

    def get_active_superuser(self) -> User:
        user = self.get_active_user()

        if not user.is_superuser:
            raise ApiException(403, "The user doesn't have enough privileges")
        return user
