#  Copyright (c) 2022. Alexandr Moroz

from .base import BaseGoal, OtherGoal, OtherTask, Statusable, Titled
from .milestone import Milestone


class GoalStatus(Titled, Statusable):
    pass


class Goal(BaseGoal):

    parent: OtherGoal | None
    goals: list[OtherGoal] | None

    tasks: list[OtherTask] | None

    status: GoalStatus | None
    milestones: list[Milestone] | None
