#  Copyright (c) 2022. Alexandr Moroz

from ..base_schema import BaseSchema, Orderable, PKGetable, PKUpsertable, Titleable


class _TaskPrioritySchema(Titleable, Orderable, BaseSchema):
    pass


class TaskPrioritySchemaGet(_TaskPrioritySchema, PKGetable):
    pass


class TaskPrioritySchemaUpsert(_TaskPrioritySchema, PKUpsertable):
    pass
