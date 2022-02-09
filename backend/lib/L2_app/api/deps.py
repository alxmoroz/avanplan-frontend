#  Copyright (c) 2022. Alexandr Moroz

from typing import Generator

from fastapi import Depends, HTTPException
from fastapi.security import OAuth2PasswordBearer
from jose import jwt
from pydantic import ValidationError
from sqlalchemy.orm import Session

from lib.L1_domain.entities import users, auth
from lib.L2_app.extra.config import settings
from lib.L3_data.repositories import user_repo
from lib.L3_data.repositories.db_repo import SessionLocal

oauth2_scheme = OAuth2PasswordBearer(tokenUrl=f"{settings.API_PATH}/auth/token")

# TODO: разделить по слоям


def get_db() -> Generator:
    db = None
    try:
        db = SessionLocal()
        yield db
    finally:
        db.close()


def get_user_by_token(
    db: Session = Depends(get_db),
    token: str = Depends(oauth2_scheme),
) -> users.User:
    try:
        payload = jwt.decode(
            token, settings.SECRET_KEY, algorithms=[jwt.ALGORITHMS.HS256]
        )
        token_data = auth.TokenPayload(**payload)
    except (jwt.JWTError, ValidationError):
        raise HTTPException(status_code=403, detail="Could not validate credentials")
    user = user_repo.get(db, p_id=token_data.sub)
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    return user


def get_current_active_user(
    current_user: users.User = Depends(get_user_by_token),
) -> users.User:
    if not current_user.is_active:
        raise HTTPException(status_code=403, detail="Inactive user")
    return current_user


def is_active_user(
    user: users.User = Depends(get_user_by_token),
) -> bool:
    if not user.is_active:
        raise HTTPException(status_code=403, detail="Inactive user")
    return True


def is_active_superuser(
    user: users.User = Depends(get_current_active_user),
) -> bool:
    if not user.is_superuser:
        raise HTTPException(
            status_code=403, detail="The user doesn't have enough privileges"
        )
    return True
