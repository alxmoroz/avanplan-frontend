#  Copyright (c) 2022. Alexandr Moroz
from dataclasses import dataclass

from ..base_entity import Identifiable, Timestampable


@dataclass
class User(Identifiable, Timestampable):
    email: str | None = None
    password: str | None = None
    full_name: str = ""
    is_active: bool = False
    is_superuser: bool = False
