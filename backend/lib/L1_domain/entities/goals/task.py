#  Copyright (c) 2022. Alexandr Moroz

from __future__ import annotations

from dataclasses import dataclass

from .person import Person
from .smartable import Smartable
from .task_priority import TaskPriority
from .task_status import TaskStatus


@dataclass
class Task(Smartable):
    status: TaskStatus | None = None
    priority: TaskPriority | None = None
    assignee: Person | None = None
    author: Person | None = None
    tasks: list[Task] | None = None

    # TODO: или при импорте или при вытаскивании из БД полной связки можно получить эту инфу. Поэтому лучше вытащить в схему...
    @property
    def closed(self):
        return self.status.closed if self.status else False
