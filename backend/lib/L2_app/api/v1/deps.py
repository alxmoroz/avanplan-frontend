#  Copyright (c) 2022. Alexandr Moroz

from typing import Generator

from fastapi import Depends, HTTPException
from fastapi.security import OAuth2PasswordBearer
from jose import jwt
from pydantic import ValidationError
from sqlalchemy.orm import Session

from lib.L3_data import crud, models, schemas
from lib.L3_data.db.session import SessionLocal
from lib.extra.config import settings

oauth2_scheme = OAuth2PasswordBearer(tokenUrl=f"{settings.API_PATH}/auth/token")


def get_db() -> Generator:
    db = None
    try:
        db = SessionLocal()
        yield db
    finally:
        db.close()


def get_user_by_token(
        db: Session = Depends(get_db), token: str = Depends(oauth2_scheme)
) -> models.user.User:
    try:
        payload = jwt.decode(
            token, settings.SECRET_KEY, algorithms=[jwt.ALGORITHMS.HS256]
        )
        token_data = schemas.TokenPayload(**payload)
    except (jwt.JWTError, ValidationError):
        raise HTTPException(status_code=403, detail="Could not validate credentials")
    user = crud.user.get(db, p_id=token_data.sub)
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    return user


def get_current_active_user(
        current_user: models.User = Depends(get_user_by_token),
) -> models.User:
    if not current_user.is_active:
        raise HTTPException(status_code=400, detail="Inactive user")
    return current_user


def is_active_superuser(user: models.User = Depends(get_current_active_user)) -> bool:
    if not user.is_superuser:
        raise HTTPException(
            status_code=403, detail="The user doesn't have enough privileges"
        )
    return True
