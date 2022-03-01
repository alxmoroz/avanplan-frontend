#  Copyright (c) 2022. Alexandr Moroz
from typing import Optional

from .base import SmartPersistent
from .goal import Goal
from .milestone_status import MilestoneStatus


class Milestone(SmartPersistent):

    goal: Goal | None
    status: Optional[MilestoneStatus]
