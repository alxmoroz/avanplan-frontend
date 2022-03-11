#  Copyright (c) 2022. Alexandr Moroz

from lib.L1_domain.entities import GoalStatus

from ..base_schema import BaseGetSchema, Identifiable, Statusable, Titleable


class GoalStatusSchema(Identifiable, Titleable, Statusable, BaseGetSchema):
    def entity(self):
        return GoalStatus(**self.dict())
