#  Copyright (c) 2022. Alexandr Moroz

from __future__ import annotations

from dataclasses import dataclass

from .person import Person
from .smartable import Smartable
from .task_priority import TaskPriority
from .task_status import TaskStatus

# TODO: в таком виде больше подходит для внутреннего использования. Отдавать в апи — много дублирования будет.


@dataclass
class Task(Smartable):

    status: TaskStatus | None = None
    priority: TaskPriority | None = None
    assignee: Person | None = None
    author: Person | None = None
    tasks: list[Task] | None = None

    @property
    def closed(self):
        return self.status.closed
