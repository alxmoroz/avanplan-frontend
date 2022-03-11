#  Copyright (c) 2022. Alexandr Moroz

from __future__ import annotations

from typing import Optional

from lib.L1_domain.entities import Task, TaskImport

from ..base_schema import BaseGetSchema, e_from_schema
from .goal import GoalImportSchemaGet
from .person import PersonSchemaGet
from .smartable import Smartable
from .task_priority import TaskPrioritySchema
from .task_status import TaskStatusSchema


class _TaskSchema(Smartable):
    pass


class TaskSchemaCreate(_TaskSchema):
    goal_id: int
    parent_id: Optional[int]
    status_id: Optional[int]
    priority_id: Optional[int]
    assignee_id: Optional[int]
    author_id: Optional[int]


class TaskSchemaGet(_TaskSchema, BaseGetSchema):
    status: Optional[TaskStatusSchema]
    author: Optional[PersonSchemaGet]
    assignee: Optional[PersonSchemaGet]
    priority: Optional[TaskPrioritySchema]

    def entity(self) -> Task:
        t = Task(**self.dict())
        t.status = e_from_schema(self.status)
        t.author = e_from_schema(self.author)
        t.assignee = e_from_schema(self.assignee)
        t.priority = e_from_schema(self.priority)
        return t


class TaskImportSchemaGet(_TaskSchema, BaseGetSchema):

    goal: Optional[GoalImportSchemaGet]
    parent: Optional[TaskImportSchemaGet]

    def entity(self) -> TaskImport:
        t = TaskImport(**self.dict())
        t.goal = e_from_schema(self.goal)
        t.parent = e_from_schema(self.parent)

        return t
