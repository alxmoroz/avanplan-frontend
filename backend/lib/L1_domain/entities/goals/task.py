#  Copyright (c) 2022. Alexandr Moroz

from __future__ import annotations

from typing import Optional

from .base import SmartPersistent
from .goal import Goal
from .milestone import Milestone
from .person import Person
from .task_priority import TaskPriority
from .task_status import TaskStatus

# TODO: в таком виде больше подходит для внутреннего использования. Отдавать в апи — много дублирования будет.


class Task(SmartPersistent):
    # tasks: list[Task] | None
    goal_id: Optional[int]
    parent: Optional[Task]
    goal: Optional[Goal]
    milestone: Optional[Milestone]
    status: Optional[TaskStatus]
    priority: Optional[TaskPriority]
    assignee: Optional[Person]
    author: Optional[Person]

    @property
    def closed(self):
        return self.status.closed
