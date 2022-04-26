#  Copyright (c) 2022. Alexandr Moroz

from ..entities import Token, TokenPayload, User
from ..entities.api.exceptions import ApiException
from ..repositories import AbstractDBRepo, AbstractSecurityRepo
from ..repositories.abstract_mapper import AbstractMapper


class AuthUC:
    def __init__(
        self,
        *,
        user_repo: AbstractDBRepo,
        user_mapper: AbstractMapper,
        security_repo: AbstractSecurityRepo,
    ):
        self.user_repo = user_repo
        self.user_mapper = user_mapper
        self.sec_repo = security_repo

    def _user_from_orm(self, obj: any) -> User | None:
        return self.user_mapper.entity_from_orm(obj) if obj else None

    def create_token_for_creds(self, username: str, password: str) -> Token:
        user: User = self._user_from_orm(self.user_repo.get_one(email=username))
        if not user or not self.sec_repo.verify_password(password, user.password):
            raise ApiException(403, "The username or password you entered is incorrect")

        return self.sec_repo.create_token(user.email)

    def get_auth_user(self) -> User:
        token_payload: TokenPayload = self.sec_repo.get_decoded_token_payload()
        # TODO: не хватает обработки протухшего токена
        user: User = self._user_from_orm(self.user_repo.get_one(email=token_payload.identifier))
        if not user:
            raise ApiException(404, "User is not found")
        return user

    def update_my_account(self, full_name: str, password: str) -> User:
        user = self.get_auth_user()

        if password is not None:
            user.password = self.sec_repo.secure_password(password)
        if full_name is not None:
            user.full_name = full_name

        s = self.user_mapper.schema_upd_from_entity(user)
        data = self.user_mapper.dict_from_schema_upd(s)
        user = self.user_mapper.entity_from_orm(self.user_repo.upsert(data))
        return user

    # def upsert_user(self, workspace_id: int, s_user: SUpd) -> User:
    #     self.get_active_superuser()
    #
    #     if self.user_repo.get_one(email=s_user.email):
    #         raise ApiException(400, "A user with this email address already exists")
    #     s_user.password = self.sec_repo.secure_password(s_user.password)
    #
    #     data = self.user_mapper.dict_from_schema_upd(s_user)
    #     user = self.user_mapper.entity_from_orm(self.user_repo.upsert(data))
    #     return user
    #
    #
    # def get_active_superuser(self) -> User:
    #     user = self._get_auth_user()
    #     ws: Workspace =
    #     # wsrole: WSRole =
    #     # ws.ws_roles
    #
    #     if not user.is_superuser:
    #         raise ApiException(403, f"The user doesn't have enough privileges in {ws.title}")
    #     return user
