#  Copyright (c) 2022. Alexandr Moroz


from lib.L1_domain.entities.auth import Token


class BaseSecurityRepo:
    @staticmethod
    def create_token(identifier: str) -> Token:
        pass

    @staticmethod
    def verify_password(password: str, hashed_password: str) -> bool:
        pass

    @staticmethod
    def get_hashed_password(password: str) -> str:
        pass
