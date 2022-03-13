#  Copyright (c) 2022. Alexandr Moroz

from __future__ import annotations

from abc import ABC
from typing import Optional

from ..base_schema import BaseSchema, Importable, PKGetable, PKUpsertable, Timestampable
from .goal_report import GoalReportSchema
from .goal_status import GoalStatusSchemaGet
from .smartable import Smartable


class GoalSchema(Smartable, Importable, BaseSchema, ABC):
    pass


class GoalSchemaGet(GoalSchema, PKGetable, Timestampable):
    status: Optional[GoalStatusSchemaGet]
    report: Optional[GoalReportSchema]


class GoalSchemaUpsert(GoalSchema, PKUpsertable):
    parent_id: Optional[int]
    status_id: Optional[int]
