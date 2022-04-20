#  Copyright (c) 2022. Alexandr Moroz

from __future__ import annotations

from dataclasses import dataclass

from .goal_import import GoalImport
from .task import Task


@dataclass
class TaskImport(Task):
    goal: GoalImport | None = None
    parent: TaskImport | None = None
    remote_parent_id: int | None = None
