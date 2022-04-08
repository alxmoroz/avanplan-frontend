#  Copyright (c) 2022. Alexandr Moroz

from __future__ import annotations

from typing import Optional

from ..base_schema import Importable, PKGetable
from .goal_import import GoalImportSchemaGet
from .task import TaskSchema, TaskSchemaUpsert


class TaskImportSchemaGet(TaskSchema, PKGetable, Importable):
    goal: Optional[GoalImportSchemaGet]
    parent: Optional[TaskImportSchemaGet]


class TaskImportSchemaUpsert(TaskSchemaUpsert):
    # remote_tracker_id: int
    pass
