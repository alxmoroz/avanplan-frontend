#  Copyright (c) 2022. Alexandr Moroz

from __future__ import annotations

from abc import ABC
from typing import Optional

from ..base_schema import BaseSchema, Importable, PKGetable, PKUpsertable, Timestampable
from .person import PersonSchemaGet
from .smartable import Smartable
from .task_priority import TaskPrioritySchemaGet
from .task_status import TaskStatusSchemaGet


class TaskSchema(Smartable, Importable, BaseSchema, ABC):
    pass


class TaskSchemaGet(TaskSchema, PKGetable, Timestampable):
    status: Optional[TaskStatusSchemaGet]
    author: Optional[PersonSchemaGet]
    assignee: Optional[PersonSchemaGet]
    priority: Optional[TaskPrioritySchemaGet]


class TaskSchemaUpsert(TaskSchema, PKUpsertable):
    goal_id: int
    parent_id: Optional[int]
    status_id: Optional[int]
    priority_id: Optional[int]
    assignee_id: Optional[int]
    author_id: Optional[int]
