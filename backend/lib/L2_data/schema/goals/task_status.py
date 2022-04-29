#  Copyright (c) 2022. Alexandr Moroz

from abc import ABC

from ..base_schema import PKGetable, PKUpsertable, Statusable, Titleable, WorkspaceBounded


class _TaskStatusSchema(Titleable, Statusable, WorkspaceBounded, ABC):
    pass


class TaskStatusSchemaGet(_TaskStatusSchema, PKGetable):
    pass


class TaskStatusSchemaUpsert(_TaskStatusSchema, PKUpsertable):
    pass
