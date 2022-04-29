#  Copyright (c) 2022. Alexandr Moroz

from dataclasses import dataclass

from ..auth.workspace_bounded import WorkspaceBounded
from ..base_entity import Orderable


@dataclass
class TaskPriority(Orderable, WorkspaceBounded):
    pass
