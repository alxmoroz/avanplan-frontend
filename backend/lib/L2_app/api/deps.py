#  Copyright (c) 2022. Alexandr Moroz


from fastapi import Depends, HTTPException
from jose import jwt
from pydantic import ValidationError

from lib.L1_domain.entities import users
from lib.L2_app.extra.config import settings
from lib.L3_data.repositories import user_repo
from lib.L3_data.repositories.security_repo import oauth2_scheme

# TODO: разделить по слоям


def get_user_by_token(
    token: str = Depends(oauth2_scheme),
) -> users.User:
    try:
        user_id = jwt.decode(
            token, settings.SECRET_KEY, algorithms=[jwt.ALGORITHMS.HS256]
        )["sub"]
    except (jwt.JWTError, ValidationError):
        raise HTTPException(status_code=403, detail="Could not validate credentials")

    user = user_repo.get_one(id=user_id)
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
