#  Copyright (c) 2022. Alexandr Moroz

from fastapi import APIRouter, Body, Depends
from fastapi.security import OAuth2PasswordRequestForm
from sqlalchemy.orm import Session

from lib.L1_domain.entities.auth import Token, User
from lib.L1_domain.usecases.auth_uc import AuthUC
from lib.L2_data.db import db_session
from lib.L2_data.mappers import UserMapper
from lib.L2_data.repositories.db import UserRepo
from lib.L2_data.repositories.security_repo import SecurityRepo, oauth2_scheme
from lib.L2_data.schema.auth import UserSchemaGet

router = APIRouter(prefix="/auth")


def _auth_uc_anon(
    db: Session = Depends(db_session),
) -> AuthUC:
    return AuthUC(
        user_repo=UserRepo(db),
        user_mapper=UserMapper(),
        security_repo=SecurityRepo(),
    )


def _auth_uc(
    auth_token: str = Depends(oauth2_scheme),
    db: Session = Depends(db_session),
) -> AuthUC:
    return AuthUC(
        user_repo=UserRepo(db),
        user_mapper=UserMapper(),
        security_repo=SecurityRepo(auth_token),
    )


def auth_user(
    uc: AuthUC = Depends(_auth_uc),
) -> User:
    return uc.get_auth_user()


def auth_db(
    user: User = Depends(auth_user),
    db: Session = Depends(db_session),
) -> Session:
    return db


@router.post("/token", response_model=Token, operation_id="get_auth_token")
def token(
    form_data: OAuth2PasswordRequestForm = Depends(),
    uc_anon: AuthUC = Depends(_auth_uc_anon),
) -> Token:
    """
    OAuth2 token login, access token for future requests
    """
    return uc_anon.create_token_for_creds(username=form_data.username, password=form_data.password)


@router.get("/my/account", response_model=UserSchemaGet)
def get_my_account(
    user: User = Depends(auth_user),
) -> User:
    return user


@router.put("/my/account", response_model=UserSchemaGet)
def update_my_account(
    password: str = Body(None),
    full_name: str = Body(None),
    uc: AuthUC = Depends(_auth_uc),
) -> User:
    return uc.update_my_account(full_name=full_name, password=password)


# TODO: другие пользователи могут видеть некоторую инфу по пользователям. Возможно, в другом методе или вьюхе это должно быть.
# @router.get("/{user_id}", response_model=schemas.User)
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

# @router.post("/reset-password/", response_model=schemas.Msg)
# def reset_password(
#         token: str = Body(...),
#         new_password: str = Body(...),
#         _db: Session = Depends(deps.get_db),
# ) -> any:
#     """
#     Reset password
#     """
#     email = verify_password_reset_token(token)
#     if not email:
#         raise HTTPException(status_code=400, detail="Invalid token")
#     user = user_repo.get_one(email=email)
#     if not user:
#         raise HTTPException(
#             status_code=404,
#             detail="The user with this username does not exist in the system.",
#         )
#     elif not user.is_active:
#         raise HTTPException(status_code=400, detail="Inactive user")
#     hashed_password = get_password_hash(new_password)
#     user.hashed_password = hashed_password
#     _db.add(user)
#     _db.commit()
#     return {"msg": "Password updated successfully"}
