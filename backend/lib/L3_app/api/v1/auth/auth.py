#  Copyright (c) 2022. Alexandr Moroz

from fastapi import APIRouter, Depends
from fastapi.security import OAuth2PasswordRequestForm
from sqlalchemy.orm import Session

from lib.L1_domain.entities.auth import Token, User
from lib.L1_domain.usecases.auth_uc import AuthUC
from lib.L2_data.db import db_session
from lib.L2_data.mappers import UserMapper
from lib.L2_data.repositories.db import UserRepo
from lib.L2_data.repositories.security_repo import SecurityRepo, oauth2_scheme

router = APIRouter(prefix="/auth")


def _auth_uc_anon(
    db: Session = Depends(db_session),
) -> AuthUC:
    return AuthUC(
        user_repo=UserRepo(db),
        user_mapper=UserMapper(),
        security_repo=SecurityRepo(),
    )


def auth_uc(
    auth_token: str = Depends(oauth2_scheme),
    db: Session = Depends(db_session),
) -> AuthUC:
    return AuthUC(
        user_repo=UserRepo(db),
        user_mapper=UserMapper(),
        security_repo=SecurityRepo(auth_token),
    )


def auth_user(
    uc: AuthUC = Depends(auth_uc),
) -> User:
    return uc.get_auth_user()


def auth_db(
    user: User = Depends(auth_user),  # noqa
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
