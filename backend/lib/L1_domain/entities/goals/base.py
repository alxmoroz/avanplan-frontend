#  Copyright (c) 2022. Alexandr Moroz
from datetime import date, datetime, timedelta
from typing import Optional

from pydantic import validator

from ..base_entity import BaseEntity, DBPersistent


class Titled(BaseEntity):
    title: str


class Importable(BaseEntity):
    remote_code: Optional[str]


class StatusablePersistent(Titled, DBPersistent):
    closed: Optional[bool]

    @validator("closed", always=True)
    def check_closed(cls, v):
        return v or False


class SmartPersistent(Titled, Importable, DBPersistent):
    _remote_parent_id: int | None
    description: Optional[str]
    due_date: Optional[datetime | date]

    @property
    def planned_period(self) -> timedelta | None:
        if self.due_date:
            return self.due_date - self.created_on

    @property
    def past_period(self) -> timedelta:
        return datetime.now() - self.created_on

    @property
    def left_period(self) -> timedelta | None:
        if self.due_date:
            return self.due_date - datetime.now()
