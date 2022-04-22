#  Copyright (c) 2022. Alexandr Moroz

from __future__ import annotations

from datetime import datetime
from typing import Optional

from ..base_schema import Importable
from .goal import GoalSchemaUpsert
from .smartable import SmartableGet


class GoalImportSchemaGet(SmartableGet, Importable):
    parent: Optional[GoalImportSchemaGet]


class GoalImportSchemaUpsert(GoalSchemaUpsert, Importable):
    remote_tracker_id: int
    created_on: Optional[datetime]
    updated_on: Optional[datetime]


class GoalImportRemoteSchemaGet(SmartableGet, Importable):
    id: Optional[int]
