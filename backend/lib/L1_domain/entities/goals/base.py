#  Copyright (c) 2022. Alexandr Moroz

from datetime import date, datetime
from typing import TypeVar

from pydantic import validator

from ..base_entity import BaseEntity, DBPersistEntity


class Titled(DBPersistEntity):
    __abstract__ = True

    title: str
    description: str | None


class Importable(BaseEntity):
    __abstract__ = True

    imported_on: datetime | None
    remote_code: str | None
    remote_parent_id: int | None


class TimeBound(BaseEntity):
    __abstract__ = True

    start_date: datetime | date | None
    due_date: datetime | date | None


class Statusable(BaseEntity):
    __abstract__ = True

    closed: bool | None

    @classmethod
    @validator("closed")
    def closed_must_filled(cls, v):
        return v or False


class BaseGoal(Titled, Importable):
    __abstract__ = True


class BaseTask(Titled, Importable, TimeBound):
    __abstract__ = True


OtherTask = TypeVar("OtherTask", bound=BaseTask)
OtherGoal = TypeVar("OtherGoal", bound=BaseGoal)
