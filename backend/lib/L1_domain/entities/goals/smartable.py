#  Copyright (c) 2022. Alexandr Moroz
from dataclasses import dataclass
from datetime import date, datetime, timedelta

from ..base_entity import Identifiable, Importable, Timestampable, Titleable


@dataclass
class Smartable(Timestampable, Titleable, Importable, Identifiable):
    description: str | None = None
    due_date: datetime | date | None = None

    @property
    def planned_period(self) -> timedelta | None:
        if self.due_date:
            return self.due_date - self.created_on

    @property
    def past_period(self) -> timedelta:
        return datetime.now() - self.created_on
