#  Copyright (c) 2022. Alexandr Moroz
from ..base_entity import DBPersistent
from .base import BaseSmartPersistent, Statusable, Titled
from .goal import Goal


class MilestoneStatus(Titled, Statusable, DBPersistent):
    pass


class Milestone(BaseSmartPersistent):

    goal: Goal | None
    status: MilestoneStatus | None
