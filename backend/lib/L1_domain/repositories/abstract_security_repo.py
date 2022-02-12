#  Copyright (c) 2022. Alexandr Moroz


from lib.L1_domain.entities.auth import Token


class AbstractSecurityRepo:
    __abstract__ = True

    @staticmethod
    def create_token(identifier: str) -> Token:
        pass

    @staticmethod
    def verify_password(password: str, hashed_password: str) -> bool:
        pass

    @staticmethod
    def secure_password(password: str) -> str:
        pass
