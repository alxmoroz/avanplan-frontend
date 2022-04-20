#  Copyright (c) 2022. Alexandr Moroz

from dataclasses import dataclass
from datetime import date, datetime

from ..base_entity import Titleable
from .person import Person
from .remote_tracker import RemoteTracker


@dataclass
class Smartable(Titleable):
    description: str | None = None
    created_on: datetime | None = None
    updated_on: datetime | None = None
    due_date: datetime | date | None = None
    remote_code: str | None = None
    remote_tracker: RemoteTracker | None = None
    remote_tracker_id: int | None = None
    parent_id: int | None = None
    closed: bool | None = False
    assignee: Person | None = None
    author: Person | None = None
