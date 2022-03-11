#  Copyright (c) 2022. Alexandr Moroz

from ..base_schema import BaseSchema, Identifiable, Statusable, Titleable


class GoalStatusSchema(Identifiable, Titleable, Statusable, BaseSchema):
    pass
