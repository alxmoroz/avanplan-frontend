#  Copyright (c) 2022. Alexandr Moroz

from datetime import datetime

from ..base_entity import BaseEntity


class TokenPayload(BaseEntity):
    expire: datetime
    identifier: str


class Token(BaseEntity):
    access_token: str
    token_type: str
