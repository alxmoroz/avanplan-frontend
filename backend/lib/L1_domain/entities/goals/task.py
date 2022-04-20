#  Copyright (c) 2022. Alexandr Moroz

from __future__ import annotations

from dataclasses import dataclass

from .smartable import Smartable
from .task_priority import TaskPriority
from .task_status import TaskStatus


@dataclass
class Task(Smartable):
    status: TaskStatus | None = None
    priority: TaskPriority | None = None
    tasks: list[Task] | None = None
