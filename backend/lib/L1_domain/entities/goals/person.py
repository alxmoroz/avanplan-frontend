#  Copyright (c) 2022. Alexandr Moroz
from dataclasses import dataclass

from ..base_entity import Identifiable, Importable, Timestampable


@dataclass
class Person(Identifiable, Importable, Timestampable):
    firstname: str | None = None
    lastname: str | None = None
