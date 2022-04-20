#  Copyright (c) 2022. Alexandr Moroz

from abc import ABC
from datetime import date, datetime
from typing import Optional

from ..base_schema import PKGetable, PKUpsertable, Titleable
from .person import PersonSchemaGet


class _Smartable(Titleable, ABC):
    description: Optional[str]
    due_date: Optional[datetime | date]
    parent_id: Optional[int]
    closed: bool


class SmartableGet(_Smartable, PKGetable, ABC):
    assignee: Optional[PersonSchemaGet]
    author: Optional[PersonSchemaGet]
    remote_tracker_id: Optional[int]


class SmartableUpsert(_Smartable, PKUpsertable, ABC):
    assignee_id: Optional[int]
    author_id: Optional[int]
    status_id: Optional[int]
