#  Copyright (c) 2022. Alexandr Moroz

from __future__ import annotations

from .goal import Goal
from .base import BaseTask, OtherGoal, Statusable, Titled
from .milestone import Milestone
from .person import Person


class TaskStatus(Titled, Statusable):
    pass


class TaskPriority(Titled):
    def __init__(self, order=0, **kwargs):
        super().__init__(order=order, **kwargs)

    order: int


# TODO: в таком виде больше подходит для внутреннего использования. Отдавать в апи — много дублирования будет.


class Task(BaseTask):
    # tasks: list[Task] | None
    parent: Task | None
    goal: Goal | None
    milestone: Milestone | None
    status: TaskStatus | None
    priority: TaskPriority | None
    assignee: Person | None
    author: Person | None
