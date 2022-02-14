#  Copyright (c) 2022. Alexandr Moroz

from fastapi import APIRouter, Body, Depends, HTTPException

from lib.L1_domain.entities.users import User
from lib.L2_data.repositories import SecurityRepo, UserRepo
from lib.L3_app.api import deps
from lib.L3_app.api.deps import get_user_repo

router = APIRouter(prefix="/users")


# TODO: тут тоже может поменять юзер репо на дб
# TODO: нужен юзкейс тут


@router.get("/", response_model=list[User])
def read_users(
    skip: int = 0,
    limit: int | None = None,
    user_repo: UserRepo = Depends(get_user_repo),
    granted: bool = Depends(deps.is_active_superuser),  # noqa
) -> list[User]:
    return user_repo.get(limit=limit, skip=skip)


@router.post("/", response_model=User, status_code=201)
def create_user(
    user_in: User,
    user_repo: UserRepo = Depends(get_user_repo),
    granted: bool = Depends(deps.is_active_superuser),  # noqa
) -> User:
    if user_repo.get_one(email=user_in.email):
        raise HTTPException(
            status_code=400,
            detail="The user with this username already exists in the system.",
        )
    user_in.password = SecurityRepo.secure_password(user_in.password)
    return user_repo.create(user_in)


@router.get("/my/account", response_model=User)
def get_my_account(
    user: User = Depends(deps.get_current_active_user),
) -> User:
    return user


@router.put("/my/account", response_model=User)
def update_my_account(
    password: str = Body(None),
    full_name: str = Body(None),
    user_repo: UserRepo = Depends(get_user_repo),
    user: User = Depends(deps.get_current_active_user),
) -> User:
    if password is not None:
        user.password = SecurityRepo.secure_password(password)
    if full_name is not None:
        user.full_name = full_name
    user_repo.update(user)
    return user


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
#     user = user.get_one(p_id=user_id)
#     if current_user == user:
#         return user
#     if not user.is_superuser:
#         raise HTTPException(
#             status_code=403, detail="The user doesn't have enough privileges"
#         )
#     return user
