#  Copyright (c) 2022. Alexandr Moroz

from fastapi import APIRouter, Body, Depends, HTTPException
from fastapi.encoders import jsonable_encoder
from pydantic.networks import EmailStr
from sqlalchemy.orm import Session

from lib.L2_app.api.v1 import deps
from lib.L3_data import crud, models, schemas

router = APIRouter()


@router.get("/", response_model=list[schemas.User])
def read_users(
        skip: int = 0,
        limit: int | None = None,
        db: Session = Depends(deps.get_db),
        granted: bool = Depends(deps.is_active_superuser),  # noqa
) -> any:
    return crud.user.get_multi(db, skip=skip, limit=limit)


@router.post("/", response_model=schemas.User, status_code=201)
def create_user(
        user_in: schemas.UserCreate,
        granted: bool = Depends(deps.is_active_superuser),  # noqa
        db: Session = Depends(deps.get_db),
) -> schemas.User:
    user = crud.user.get_by_email(db, email=user_in.email)
    if user:
        raise HTTPException(
            status_code=400,
            detail="The user with this username already exists in the system.",
        )
    return crud.user.create(db, obj_in=user_in)


@router.get("/my/account", response_model=schemas.User)
def get_my_account(
        user: models.User = Depends(deps.get_current_active_user),
) -> any:
    return user


@router.put("/my/account", response_model=schemas.User)
def update_my_account(
        password: str = Body(None),
        full_name: str = Body(None),
        email: EmailStr = Body(None),
        current_user: models.User = Depends(deps.get_current_active_user),
        db: Session = Depends(deps.get_db),
) -> any:
    current_user_data = jsonable_encoder(current_user)
    user_in = schemas.UserUpdate(**current_user_data)
    if password is not None:
        user_in.password = password
    if full_name is not None:
        user_in.full_name = full_name
    if email is not None:
        user_in.email = email

    return crud.user.update(db, db_obj=current_user, obj_in=user_in)

# TODO: другие пользователи могут видеть некоторую инфу по пользователям. Возможно, в другом методе или вьюхе это должно быть.
# @router.get("/{user_id}", response_model=schemas.User)
# def get_user_by_id(
#     user_id: int,
#     db: Session = Depends(deps.get_db),
#     current_user: models.User = Depends(deps.get_current_active_user),
# ) -> any:
#     """
#     Get a specific user by id.
#     """
#     user = crud.user.get(db, p_id=user_id)
#     if current_user == user:
#         return user
#     if not user.is_superuser:
#         raise HTTPException(
#             status_code=403, detail="The user doesn't have enough privileges"
#         )
#     return user
