#  Copyright (c) 2022. Alexandr Moroz
from .base import Importable, Statusable, TrackerEntity


class GoalStatus(TrackerEntity, Statusable):
    pass


class Goal(TrackerEntity, Importable):

    parent_id: int | None
    _parent: any

    status_id: int | None
    _status: GoalStatus | None

    @property
    def parent(self) -> any:
        return self._parent

    @property
    def status(self) -> GoalStatus:
        return self._status
