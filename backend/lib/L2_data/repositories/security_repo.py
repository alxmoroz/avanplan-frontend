#  Copyright (c) 2022. Alexandr Moroz

from datetime import datetime, timedelta

from fastapi.security import OAuth2PasswordBearer
from jose import jwt
from passlib.context import CryptContext

from lib.L1_domain.entities.auth import Token
from lib.L1_domain.repositories.abstract_security_repo import AbstractSecurityRepo
from lib.L3_app.settings import settings

pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

oauth2_scheme = OAuth2PasswordBearer(tokenUrl=f"{settings.API_PATH}/auth/token")


class SecurityRepo(AbstractSecurityRepo):
    @staticmethod
    def create_token(identifier: str) -> Token:
        expire = datetime.utcnow() + timedelta(minutes=settings.AUTH_TOKEN_EXPIRATION_MINUTES)
        return Token(
            access_token=jwt.encode(
                {"exp": expire, "sub": identifier},
                settings.SECRET_KEY,
                algorithm=jwt.ALGORITHMS.HS256,
            ),
            token_type="bearer",
        )

    @staticmethod
    def verify_password(password: str, hashed_password: str) -> bool:
        return pwd_context.verify(password, hashed_password)

    @staticmethod
    def secure_password(password: str) -> str:
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
