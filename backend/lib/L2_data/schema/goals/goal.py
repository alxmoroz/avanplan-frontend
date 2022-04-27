#  Copyright (c) 2022. Alexandr Moroz

from typing import Optional

from ..auth import WorkspaceSchemaGet
from ..base_schema import Timestampable
from .smartable import SmartableGet, SmartableUpsert
from .task import TaskSchemaGet


class GoalSchemaGet(SmartableGet, Timestampable):
    tasks: Optional[list[TaskSchemaGet]]
    workspace: WorkspaceSchemaGet


class GoalSchemaUpsert(SmartableUpsert):
    workspace_id: int
