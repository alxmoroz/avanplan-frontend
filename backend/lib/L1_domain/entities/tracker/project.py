#  Copyright (c) 2022. Alexandr Moroz
from .base import Importable, Statusable, TrackerEntity


class ProjectStatus(TrackerEntity, Statusable):
    pass


class Project(TrackerEntity, Importable):

    parent_id: int | None
    _parent: any

    status_id: int | None
    _status: ProjectStatus | None

    @property
    def parent(self) -> any:
        return self._parent

    @property
    def status(self) -> ProjectStatus:
        return self._status
