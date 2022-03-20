#  Copyright (c) 2022. Alexandr Moroz

from __future__ import annotations

from abc import ABC
from typing import Optional

from ..base_schema import BaseSchema, PKGetable, PKUpsertable, Timestampable
from .person import PersonSchemaGet
from .smartable import Smartable
from .task_priority import TaskPrioritySchemaGet
from .task_status import TaskStatusSchemaGet


class TaskSchema(Smartable, BaseSchema, ABC):
    pass


class TaskSchemaGet(TaskSchema, PKGetable, Timestampable):
    status: Optional[TaskStatusSchemaGet]
    priority: Optional[TaskPrioritySchemaGet]
    assignee: Optional[PersonSchemaGet]
    author: Optional[PersonSchemaGet]
    tasks: Optional[list[TaskSchemaGet]]


class TaskSchemaUpsert(TaskSchema, PKUpsertable):
    goal_id: int
    status_id: Optional[int]
    priority_id: Optional[int]
    assignee_id: Optional[int]
    author_id: Optional[int]
