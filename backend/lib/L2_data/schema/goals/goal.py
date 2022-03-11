#  Copyright (c) 2022. Alexandr Moroz

from __future__ import annotations

from abc import ABC
from typing import Optional

from ..base_schema import BaseSchema
from .goal_report import GoalReportSchema
from .goal_status import GoalStatusSchema
from .smartable import Smartable


class _GoalSchema(Smartable, BaseSchema, ABC):
    pass


class GoalSchemaCreate(_GoalSchema):
    parent_id: Optional[int]
    status_id: Optional[int]


class GoalSchemaGet(_GoalSchema):
    status: Optional[GoalStatusSchema]
    report: Optional[GoalReportSchema]


class GoalImportSchemaGet(_GoalSchema):
    parent: Optional[GoalImportSchemaGet]
