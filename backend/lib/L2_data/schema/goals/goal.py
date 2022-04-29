#  Copyright (c) 2022. Alexandr Moroz
from abc import ABC
from typing import Optional

from ..base_schema import Timestampable, WorkspaceBounded
from .smartable import SmartableGet, SmartableUpsert
from .task import TaskSchemaGet


class _GoalSchema(WorkspaceBounded, ABC):
    pass


class GoalSchemaGet(_GoalSchema, SmartableGet, Timestampable):
    tasks: Optional[list[TaskSchemaGet]]


class GoalSchemaUpsert(_GoalSchema, SmartableUpsert):
    pass
