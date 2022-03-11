#  Copyright (c) 2022. Alexandr Moroz

from __future__ import annotations

from typing import Optional

from lib.L1_domain.entities import Goal, GoalImport

from ..base_schema import BaseGetSchema, e_from_schema
from .goal_report import GoalReportSchema
from .goal_status import GoalStatusSchema
from .smartable import Smartable


class _GoalSchema(Smartable):
    pass


class GoalSchemaCreate(_GoalSchema):
    parent_id: Optional[int]
    status_id: Optional[int]


class GoalSchemaGet(_GoalSchema, BaseGetSchema):
    status: Optional[GoalStatusSchema]
    report: Optional[GoalReportSchema]

    def entity(self):
        g = Goal(**self.dict())
        g.status = e_from_schema(self.status)
        g.report = e_from_schema(self.report)
        return g


class GoalImportSchemaGet(_GoalSchema, BaseGetSchema):
    parent: Optional[GoalImportSchemaGet]

    def entity(self):
        g = GoalImport(**self.dict())
        g.parent = e_from_schema(self.parent)
        return g
