#  Copyright (c) 2022. Alexandr Moroz

from fastapi import APIRouter, Body, Depends
from sqlalchemy.orm import Session

from lib.L1_domain.entities.users import User
from lib.L1_domain.usecases.users_uc import UsersUC
from lib.L2_data.db import db_session
from lib.L2_data.mappers import UserMapper
from lib.L2_data.repositories.db import UserRepo
from lib.L2_data.repositories.security_repo import SecurityRepo, oauth2_scheme
from lib.L2_data.schema.users import UserSchemaGet, UserSchemaUpsert

router = APIRouter(prefix="/users")


def user_uc(
    token: str = Depends(oauth2_scheme),
    db: Session = Depends(db_session),
) -> UsersUC:
    return UsersUC(
        db_repo=UserRepo(db),
        e_repo=UserMapper(),
        security_repo=SecurityRepo(token),
    )


@router.get("/", response_model=list[UserSchemaGet])
def get_users(
    skip: int = 0,
    limit: int | None = None,
    uc: UsersUC = Depends(user_uc),
) -> list[User]:
    return uc.get_users(skip, limit)


@router.post("/", response_model=UserSchemaGet, status_code=201)
def upsert_user(
    user_in: UserSchemaUpsert,
    uc: UsersUC = Depends(user_uc),
) -> User:
    return uc.upsert_user(user_in)


@router.get("/my/account", response_model=UserSchemaGet)
def get_my_account(
    uc: UsersUC = Depends(user_uc),
) -> User:
    return uc.get_active_user()


@router.put("/my/account", response_model=UserSchemaGet)
def update_my_account(
    password: str = Body(None),
    full_name: str = Body(None),
    uc: UsersUC = Depends(user_uc),
) -> User:
    return uc.update_my_account(full_name=full_name, password=password)


# TODO: другие пользователи могут видеть некоторую инфу по пользователям. Возможно, в другом методе или вьюхе это должно быть.
# @integrations_router.get("/{user_id}", response_model=schemas.User)
# def get_user_by_id(
#     user_id: int,
#     _db: Session = Depends(deps.get_db),
#     current_user: UserModel = Depends(deps.get_current_active_user),
# ) -> UserModel:
#     """
#     Get a specific user by id.
#     """
#     user = user.get_one(p_id=user_id)
#     if current_user == user:
#         return user
#     if not user.is_superuser:
#         raise HTTPException(
#             status_code=403, detail="The user doesn't have enough privileges"
#         )
#     return user
