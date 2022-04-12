#  Copyright (c) 2022. Alexandr Moroz

from dataclasses import dataclass
from datetime import date, datetime

from ..base_entity import Titleable
from .remote_tracker import RemoteTracker


@dataclass
class Smartable(Titleable):
    description: str | None = None
    created_on: datetime | None = None
    updated_on: datetime | None = None
    due_date: datetime | date | None = None
    remote_code: str | None = None
    # TODO: remote_tracker автоматом попадает на фронт. Надо ли?
    remote_tracker: RemoteTracker | None = None
    parent_id: int | None = None
    closed: bool | None = False
