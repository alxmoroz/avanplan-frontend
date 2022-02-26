#  Copyright (c) 2022. Alexandr Moroz
from . import Milestone, Project
from .base import Importable, Statusable, TimeBound, TrackerEntity
from .person import Person


class TaskStatus(TrackerEntity, Statusable):
    pass


class TaskPriority(TrackerEntity):
    def __init__(self, order=0, **kwargs):
        super().__init__(order=order, **kwargs)

    order: int


# TODO: вместо приватных полей и геттеров можно использовать отдельный класс для создания при импорте из внешки.
#  Потому что эти поля только для этого случая и нужны


class Task(TrackerEntity, Importable, TimeBound):

    project_id: int | None
    _project: Project | None

    parent_id: int | None
    _parent: any

    milestone_id: int | None
    _milestone: Milestone | None

    status_id: int | None
    _status: TaskStatus | None

    priority_id: int | None
    _priority: TaskPriority | None

    assignee_id: int | None
    _assignee: Person | None

    author_id: int | None
    _author: Person | None

    @property
    def project(self) -> Project:
        return self._project

    @property
    def parent(self) -> any:
        return self._parent

    @property
    def milestone(self) -> Milestone:
        return self._milestone

    @property
    def status(self) -> TaskStatus:
        return self._status

    @property
    def priority(self) -> TaskPriority:
        return self._priority

    @property
    def assigned_person(self) -> Person:
        return self._assignee

    @property
    def author(self) -> Person:
        return self._author
