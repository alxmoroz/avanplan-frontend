#  Copyright (c) 2022. Alexandr Moroz

from __future__ import annotations

from typing import Optional

from pydantic import validator

from .base import DBPersistent, Titled


class TaskPriority(Titled, DBPersistent):

    order: Optional[int]

    @validator("order", always=True)
    def check_order(cls, v):
        return v or 0
