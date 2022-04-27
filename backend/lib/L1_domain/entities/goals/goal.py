#  Copyright (c) 2022. Alexandr Moroz

from dataclasses import dataclass

from ..auth.workspace import WorkspaceBounded
from .smartable import Smartable
from .task import Task


@dataclass
class Goal(Smartable, WorkspaceBounded):
    tasks: list[Task] | None = None
