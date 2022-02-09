#  Copyright (c) 2022. Alexandr Moroz

from ..base_entity import BaseEntity


class Token(BaseEntity):
    access_token: str
    token_type: str


class TokenPayload(BaseEntity):
    sub: int | None
