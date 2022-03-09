#  Copyright (c) 2022. Alexandr Moroz
from datetime import datetime, timedelta

from fastapi.security import OAuth2PasswordBearer
from jose import jwt
from passlib.context import CryptContext
from pydantic import ValidationError

from lib.L1_domain.entities.api.exceptions import ApiException
from lib.L1_domain.entities.auth import Token, TokenPayload
from lib.L1_domain.repositories.abstract_security_repo import AbstractSecurityRepo

from ..settings import settings

_pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

oauth2_scheme = OAuth2PasswordBearer(tokenUrl=f"{settings.API_PATH}/auth/token")


class SecurityRepo(AbstractSecurityRepo):
    def get_decoded_token_payload(self) -> TokenPayload:
        try:
            return TokenPayload(**jwt.decode(self.encoded_token, settings.SECRET_KEY, algorithms=[jwt.ALGORITHMS.HS256]))
        except (jwt.JWTError, ValidationError):
            raise ApiException(403, "Could not validate credentials")

    @staticmethod
    def create_token(identifier: str) -> Token:
        expire = datetime.now() + timedelta(minutes=settings.AUTH_TOKEN_EXPIRATION_MINUTES)

        return Token(
            access_token=jwt.encode(
                dict(expire=expire.isoformat(), identifier=identifier),
                settings.SECRET_KEY,
                algorithm=jwt.ALGORITHMS.HS256,
            ),
            token_type="bearer",
        )

    @staticmethod
    def verify_password(password: str, hashed_password: str) -> bool:
        return _pwd_context.verify(password, hashed_password)

    @staticmethod
    def secure_password(password: str) -> str:
        return _pwd_context.hash(password)

    # def generate_password_reset_token(email: str) -> str:
    #     delta = timedelta(hours=settings.EMAIL_RESET_TOKEN_EXPIRE_HOURS)
    #     now = datetime.utcnow()
    #     expires = now + delta
    #     expire = expires.timestamp()
    #     encoded_jwt = jwt.encode(
    #         {"expire": expire, "nbf": now, "identifier": email},
    #         settings.SECRET_KEY
    #     )
    #     return encoded_jwt

    # def verify_password_reset_token(token: str) -> str | None:
    #     try:
    #         decoded_token = jwt.decode(token, settings.SECRET_KEY, algorithms=[jwt.ALGORITHMS.HS256])
    #         return decoded_token["email"]
    #     except jwt.JWTError:
    #         return None
