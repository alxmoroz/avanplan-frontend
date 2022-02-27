#  Copyright (c) 2022. Alexandr Moroz
from .base import Importable, OtherGoal, OtherTask, Statusable, TimeBound, Titled


class MilestoneStatus(Titled, Statusable):
    pass


class BaseMilestone(Titled, Importable, TimeBound):
    pass


class Milestone(BaseMilestone):

    goal: OtherGoal | None
    status: MilestoneStatus | None
    tasks: list[OtherTask] | None
