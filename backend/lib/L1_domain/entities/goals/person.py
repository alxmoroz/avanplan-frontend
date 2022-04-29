#  Copyright (c) 2022. Alexandr Moroz

from dataclasses import dataclass

from ..auth.workspace_bounded import WorkspaceBounded
from ..base_entity import Emailable, Persistable


@dataclass
class Person(Persistable, Emailable, WorkspaceBounded):
    firstname: str | None = None
    lastname: str | None = None
    email: str | None = None
