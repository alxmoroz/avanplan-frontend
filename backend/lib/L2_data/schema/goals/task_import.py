#  Copyright (c) 2022. Alexandr Moroz

from __future__ import annotations

from typing import Optional

from ..base_schema import Importable
from .goal_import import GoalImportSchemaGet
from .smartable import SmartableGet
from .task import TaskSchemaUpsert


class TaskImportSchemaGet(SmartableGet, Importable):
    goal: Optional[GoalImportSchemaGet]
    parent: Optional[TaskImportSchemaGet]


class TaskImportSchemaUpsert(TaskSchemaUpsert, Importable):
    remote_tracker_id: int
