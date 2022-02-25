#  Copyright (c) 2022. Alexandr Moroz
from . import Project
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


# TODO: вместо приватных полей и геттеров можно использовать отдельный класс для создания при импорте из внешки.
#  Потому что эти поля только для этого случая и нужны


class Task(BaseTrackerEntity, Importable, TimeBound):

    project_id: int | None
    _project: Project | None

    status_id: int | None
    _status: TaskStatus | None

    priority_id: int | None
    _priority: TaskPriority | None

    assigned_person_id: int | None
    _assigned_person: Person | None

    author_id: int | None
    _author: Person | None

    parent_id: int | None
    _parent: any

    @property
    def project(self) -> Project:
        return self._project

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

    @property
    def parent(self) -> any:
        return self._parent
