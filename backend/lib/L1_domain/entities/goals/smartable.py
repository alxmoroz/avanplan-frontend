#  Copyright (c) 2022. Alexandr Moroz

from dataclasses import dataclass
from datetime import date, datetime, timedelta

from pytz import utc

from ..base_entity import Titleable


@dataclass
class Smartable(Titleable):
    description: str | None = None
    created_on: datetime | None = None
    updated_on: datetime | None = None
    due_date: datetime | date | None = None
    remote_code: str | None = None

    @property
    def planned_period(self) -> timedelta | None:
        if self.due_date:
            return self.due_date - self.created_on

    @property
    def past_period(self) -> timedelta:
        return datetime.now(tz=utc) - self.created_on
