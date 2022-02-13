#  Copyright (c) 2022. Alexandr Moroz


from lib.L1_domain.entities.auth import Token


class AbstractSecurityRepo:
    __abstract__ = True

    @staticmethod
    def create_token(identifier: str) -> Token:
        raise NotImplementedError

    @staticmethod
    def verify_password(password: str, hashed_password: str) -> bool:
        raise NotImplementedError

    @staticmethod
    def secure_password(password: str) -> str:
        raise NotImplementedError
