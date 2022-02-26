#  Copyright (c) 2022. Alexandr Moroz
from .base import Importable, Statusable, TimeBound, TrackerEntity
from .project import Project


class MilestoneStatus(TrackerEntity, Statusable):
    pass


class Milestone(TrackerEntity, Importable, TimeBound):

    project_id: int | None
    _project: Project | None

    status_id: int | None
    _status: MilestoneStatus | None

    @property
    def project(self) -> Project:
        return self._project

    @property
    def status(self) -> MilestoneStatus:
        return self._status
