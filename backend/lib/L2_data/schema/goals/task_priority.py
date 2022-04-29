#  Copyright (c) 2022. Alexandr Moroz
from abc import ABC

from ..base_schema import Orderable, PKGetable, PKUpsertable, Titleable, WorkspaceBounded


class _TaskPrioritySchema(Titleable, Orderable, WorkspaceBounded, ABC):
    pass


class TaskPrioritySchemaGet(_TaskPrioritySchema, PKGetable):
    pass


class TaskPrioritySchemaUpsert(_TaskPrioritySchema, PKUpsertable):
    pass
