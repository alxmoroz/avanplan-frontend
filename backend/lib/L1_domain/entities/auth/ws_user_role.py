#  Copyright (c) 2022. Alexandr Moroz

from dataclasses import dataclass

from ..base_entity import Persistable
from .user import User
from .workspace import Workspace
from .ws_role import WSRole


@dataclass
class WSUserRole(Persistable):
    workspace: Workspace = None
    user: User = None
    ws_role: WSRole = None
