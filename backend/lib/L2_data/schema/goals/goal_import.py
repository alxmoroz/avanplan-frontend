#  Copyright (c) 2022. Alexandr Moroz

from __future__ import annotations

from typing import Optional

from ..base_schema import Importable, PKGetable
from .goal import GoalSchema


class GoalImportSchemaGet(GoalSchema, PKGetable, Importable):
    parent: Optional[GoalImportSchemaGet]
