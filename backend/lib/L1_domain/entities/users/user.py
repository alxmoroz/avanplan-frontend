#  Copyright (c) 2022. Alexandr Moroz
from dataclasses import dataclass

from ..base_entity import Emailable, Persistable


@dataclass
class User(Persistable, Emailable):

    password: str | None = None
    full_name: str = ""
    is_active: bool = False
    is_superuser: bool = False
