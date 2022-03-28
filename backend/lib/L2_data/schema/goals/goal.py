#  Copyright (c) 2022. Alexandr Moroz

from __future__ import annotations

from abc import ABC
from typing import Optional

from ..base_schema import BaseSchema, PKGetable, PKUpsertable, Timestampable
from .goal_status import GoalStatusSchemaGet
from .smartable import Smartable
from .task import TaskSchemaGet


class GoalSchema(Smartable, BaseSchema, ABC):
    pass


class GoalSchemaGet(GoalSchema, PKGetable, Timestampable):
    status: Optional[GoalStatusSchemaGet]
    tasks: Optional[list[TaskSchemaGet]]


class GoalSchemaUpsert(GoalSchema, PKUpsertable):
    status_id: Optional[int]
