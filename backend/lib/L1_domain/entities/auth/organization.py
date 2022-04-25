#  Copyright (c) 2022. Alexandr Moroz

from dataclasses import dataclass

from ..base_entity import Persistable


@dataclass
class Organization(Persistable):
    name: str = None
