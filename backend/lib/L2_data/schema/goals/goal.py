#  Copyright (c) 2022. Alexandr Moroz
from typing import Optional

from .goal_report import GoalReportSchema
from .goal_status import GoalStatusSchema
from .smartable import Smartable


class GoalSchemaCreate(Smartable):
    parent_id: Optional[int]
    status_id: Optional[int]


class GoalSchemaGet(Smartable):
    status: Optional[GoalStatusSchema]
    report: Optional[GoalReportSchema]
