#  Copyright (c) 2022. Alexandr Moroz

from ..base_schema import BaseSchema, PKGetable, PKUpsertable, Statusable, Titleable


class _TaskStatusSchema(Titleable, Statusable, BaseSchema):
    pass


class TaskStatusSchemaGet(PKGetable, _TaskStatusSchema):
    pass


class TaskStatusSchemaUpsert(_TaskStatusSchema, PKUpsertable):
    pass
