#  Copyright (c) 2022. Alexandr Moroz
from .base import Importable, Statusable, TimeBound, TrackerEntity
from .goal import Goal


class MilestoneStatus(TrackerEntity, Statusable):
    pass


class Milestone(TrackerEntity, Importable, TimeBound):

    goal_id: int | None
    _goal: Goal | None

    status_id: int | None
    _status: MilestoneStatus | None

    @property
    def goal(self) -> Goal:
        return self._goal

    @property
    def status(self) -> MilestoneStatus:
        return self._status
