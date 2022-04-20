#  Copyright (c) 2022. Alexandr Moroz

from __future__ import annotations

from typing import Optional

from ..base_schema import Timestampable
from .smartable import SmartableGet, SmartableUpsert
from .task_priority import TaskPrioritySchemaGet
from .task_status import TaskStatusSchemaGet


class TaskSchemaGet(SmartableGet, Timestampable):
    status: Optional[TaskStatusSchemaGet]
    priority: Optional[TaskPrioritySchemaGet]
    tasks: Optional[list[TaskSchemaGet]]


class TaskSchemaUpsert(SmartableUpsert):
    goal_id: int
    priority_id: Optional[int]
