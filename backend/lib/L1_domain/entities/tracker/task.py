#  Copyright (c) 2022. Alexandr Moroz

from .base_tracker import BaseTrackerEntity, Importable, TimeBound
from .person import Person


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

    assigned_person_id: int | None
    _assigned_person: Person | None

    author_id: int | None
    _author: Person | None

    @property
    def status(self) -> TaskStatus:
        return self._status

    @property
    def priority(self) -> TaskPriority:
        return self._priority

    @property
    def assigned_person(self) -> Person:
        return self._assigned_person

    @property
    def author(self) -> Person:
        return self._author

    # version: Version | None
    # tasks: list[Task] | None

    project_id: int | None
