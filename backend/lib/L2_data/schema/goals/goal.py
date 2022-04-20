#  Copyright (c) 2022. Alexandr Moroz

from typing import Optional

from ..base_schema import Timestampable
from .goal_status import GoalStatusSchemaGet
from .smartable import SmartableGet, SmartableUpsert
from .task import TaskSchemaGet


class GoalSchemaGet(SmartableGet, Timestampable):
    status: Optional[GoalStatusSchemaGet]
    tasks: Optional[list[TaskSchemaGet]]


class GoalSchemaUpsert(SmartableUpsert):
    pass
