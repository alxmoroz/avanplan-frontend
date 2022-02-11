#  Copyright (c) 2022. Alexandr Moroz

from fastapi import APIRouter, Body, Depends, HTTPException
from fastapi.encoders import jsonable_encoder
from pydantic.networks import EmailStr

from lib.L1_domain.entities.users import User
from lib.L2_app.api import deps
from lib.L3_data.models.users import User as UserModel
from lib.L3_data.repositories import user_repo

router = APIRouter()


@router.get("/", response_model=list[User])
def read_users(
    skip: int = 0,
    limit: int | None = None,
    granted: bool = Depends(deps.is_active_superuser),  # noqa
) -> list[User]:
    return user_repo.get(filter_by=dict(), skip=skip, limit=limit)


@router.post("/", response_model=User, status_code=201)
def create_user(
    user_in: User,
    granted: bool = Depends(deps.is_active_superuser),  # noqa
) -> User:
    user = user_repo.get_by_email(user_in.email)
    if user:
        raise HTTPException(
            status_code=400,
            detail="The user with this username already exists in the system.",
        )
    return user_repo.create(user_in)


@router.get("/my/account", response_model=User)
def get_my_account(
    user: UserModel = Depends(deps.get_current_active_user),
) -> User:
    return user


@router.put("/my/account", response_model=User)
def update_my_account(
    password: str = Body(None),
    full_name: str = Body(None),
    email: EmailStr = Body(None),
    user: UserModel = Depends(deps.get_current_active_user),
) -> User:
    user_data = jsonable_encoder(user)
    user_in = User(**user_data)
    if password is not None:
        user_in.password = password
    if full_name is not None:
        user_in.full_name = full_name
    if email is not None:
        user_in.email = email
    user_repo.update(user_in)
    return user_in


# TODO: другие пользователи могут видеть некоторую инфу по пользователям. Возможно, в другом методе или вьюхе это должно быть.
# @router.get("/{user_id}", response_model=schemas.User)
# def get_user_by_id(
#     user_id: int,
#     db: Session = Depends(deps.get_db),
#     current_user: UserModel = Depends(deps.get_current_active_user),
# ) -> UserModel:
#     """
#     Get a specific user by id.
#     """
#     user = user.get(db, p_id=user_id)
#     if current_user == user:
#         return user
#     if not user.is_superuser:
#         raise HTTPException(
#             status_code=403, detail="The user doesn't have enough privileges"
#         )
#     return user
