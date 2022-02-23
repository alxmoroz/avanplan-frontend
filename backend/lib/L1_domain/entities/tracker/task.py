#  Copyright (c) 2022. Alexandr Moroz

from .base_tracker import BaseTrackerEntity, Importable, TimeBound


class TaskStatus(BaseTrackerEntity):
    def __init__(self, closed=False, **kwargs):
        super().__init__(closed=closed, **kwargs)

    closed: bool


class TaskPriority(BaseTrackerEntity):
    def __init__(self, order=0, **kwargs):
        super().__init__(order=order, **kwargs)

    order: int


class Task(BaseTrackerEntity, Importable, TimeBound):

    status_id: int | None
    _status: TaskStatus | None

    priority_id: int | None
    _priority: TaskPriority | None

    @property
    def status(self) -> TaskStatus:
        return self._status

    @property
    def priority(self) -> TaskPriority:
        return self._priority

    # version: Version | None
    # tasks: list[Task] | None
    # assigned_to: Person | None
    # author: Person | None
    project_id: int | None
