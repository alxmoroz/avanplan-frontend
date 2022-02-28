#  Copyright (c) 2022. Alexandr Moroz
from .base import BaseMilestone, OtherGoal, Statusable, Titled

# TODO: кандидат на утилизацию или перенос в репу импорта из трекеров


class MilestoneStatus(Titled, Statusable):
    pass


class Milestone(BaseMilestone):

    goal: OtherGoal | None
    status: MilestoneStatus | None
