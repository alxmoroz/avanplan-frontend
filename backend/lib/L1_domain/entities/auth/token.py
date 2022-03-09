#  Copyright (c) 2022. Alexandr Moroz
from dataclasses import dataclass
from datetime import datetime


@dataclass
class TokenPayload:
    expire: datetime
    identifier: str


@dataclass
class Token:
    access_token: str
    token_type: str
