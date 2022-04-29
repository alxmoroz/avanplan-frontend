#  Copyright (c) 2022. Alexandr Moroz

from dataclasses import dataclass

from ..auth.workspace_bounded import WorkspaceBounded
from .smartable import Smartable
from .task import Task


@dataclass
class Goal(Smartable, WorkspaceBounded):
    tasks: list[Task] | None = None
