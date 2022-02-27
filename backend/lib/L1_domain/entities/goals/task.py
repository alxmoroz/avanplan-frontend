#  Copyright (c) 2022. Alexandr Moroz

from .base import BaseTask, OtherGoal, OtherTask, Statusable, Titled
from .milestone import Milestone
from .person import Person


class TaskStatus(Titled, Statusable):
    pass


class TaskPriority(Titled):
    def __init__(self, order=0, **kwargs):
        super().__init__(order=order, **kwargs)

    order: int


class Task(BaseTask):
    parent: OtherTask | None
    tasks: list[OtherTask] | None

    goal: OtherGoal | None
    milestone: Milestone | None
    status: TaskStatus | None
    priority: TaskPriority | None
    assignee: Person | None
    author: Person | None
