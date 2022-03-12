#  Copyright (c) 2022. Alexandr Moroz

from __future__ import annotations

from abc import ABC
from typing import Optional

from ..base_schema import BaseSchema, Importable, Timestampable
from .goal import GoalImportSchemaGet
from .person import PersonSchemaGet
from .smartable import Smartable
from .task_priority import TaskPrioritySchema
from .task_status import TaskStatusSchema


class _TaskSchema(Smartable, BaseSchema, ABC):
    pass


class TaskSchemaCreate(_TaskSchema):
    goal_id: int
    parent_id: Optional[int]
    status_id: Optional[int]
    priority_id: Optional[int]
    assignee_id: Optional[int]
    author_id: Optional[int]


class TaskSchemaGet(_TaskSchema, Importable, Timestampable):
    status: Optional[TaskStatusSchema]
    author: Optional[PersonSchemaGet]
    assignee: Optional[PersonSchemaGet]
    priority: Optional[TaskPrioritySchema]


class TaskImportSchemaGet(_TaskSchema, Importable):
    goal: Optional[GoalImportSchemaGet]
    parent: Optional[TaskImportSchemaGet]
