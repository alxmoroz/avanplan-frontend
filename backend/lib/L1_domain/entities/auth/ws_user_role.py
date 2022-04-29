#  Copyright (c) 2022. Alexandr Moroz

from dataclasses import dataclass

from ..base_entity import Persistable
from .workspace import Workspace


@dataclass
class WSUserRole(Persistable):
    workspace: Workspace = None
    user_id: int = None
    ws_role_id: int = None
