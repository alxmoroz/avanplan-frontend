#  Copyright (c) 2022. Alexandr Moroz

from datetime import datetime, timedelta
from typing import Union

from jose import jwt
from passlib.context import CryptContext

from .config import settings

pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

# 60 minutes * 24 hours * 7 days = 7 days
AUTH_TOKEN_EXPIRATION_MINUTES: int = 60 * 24 * 7


def create_token(subject: Union[str, any], expires_delta: timedelta = None) -> str:
    if expires_delta:
        expire = datetime.utcnow() + expires_delta
    else:
        expire = datetime.utcnow() + timedelta(minutes=AUTH_TOKEN_EXPIRATION_MINUTES)
    to_encode = {"exp": expire, "sub": str(subject)}
    return jwt.encode(to_encode, settings.SECRET_KEY, algorithm=jwt.ALGORITHMS.HS256)


def verify_password(plain_password: str, hashed_password: str) -> bool:
    return pwd_context.verify(plain_password, hashed_password)


def get_password_hash(password: str) -> str:
    return pwd_context.hash(password)


# def generate_password_reset_token(email: str) -> str:
#     delta = timedelta(hours=settings.EMAIL_RESET_TOKEN_EXPIRE_HOURS)
#     now = datetime.utcnow()
#     expires = now + delta
#     exp = expires.timestamp()
#     encoded_jwt = jwt.encode(
#         {"exp": exp, "nbf": now, "sub": email},
#         settings.SECRET_KEY
#     )
#     return encoded_jwt


# def verify_password_reset_token(token: str) -> str | None:
#     try:
#         decoded_token = jwt.decode(token, settings.SECRET_KEY, algorithms=[jwt.ALGORITHMS.HS256])
#         return decoded_token["email"]
#     except jwt.JWTError:
#         return None
