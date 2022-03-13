#  Copyright (c) 2022. Alexandr Moroz

from ..base_schema import BaseSchema, PKGetable, PKUpsertable, Statusable, Titleable


class _GoalStatusSchema(Titleable, Statusable, BaseSchema):
    pass


class GoalStatusSchemaGet(_GoalStatusSchema, PKGetable):
    pass


class GoalStatusSchemaUpsert(_GoalStatusSchema, PKUpsertable):
    pass
