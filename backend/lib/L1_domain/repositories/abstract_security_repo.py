#  Copyright (c) 2022. Alexandr Moroz


from ..entities.auth import Token, TokenPayload


class AbstractSecurityRepo:
    def __init__(self, encoded_token: str | None = None):
        self.encoded_token = encoded_token

    def get_decoded_token_payload(self) -> TokenPayload:
        raise NotImplementedError

    @staticmethod
    def create_token(identifier: str) -> Token:
        raise NotImplementedError

    @staticmethod
    def verify_password(password: str, hashed_password: str) -> bool:
        raise NotImplementedError

    @staticmethod
    def secure_password(password: str) -> str:
        raise NotImplementedError
