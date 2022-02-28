#  Copyright (c) 2022. Alexandr Moroz

from datetime import date, datetime

from pydantic import validator

from ..base_entity import BaseEntity, DBPersistent


class Titled(BaseEntity):
    __abstract__ = True

    title: str
    description: str | None


class Importable(BaseEntity):
    __abstract__ = True

    imported_on: datetime | None
    remote_code: str | None


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


class BaseSmartPersistent(Titled, Importable, TimeBound, DBPersistent):
    __abstract__ = True
    _remote_parent_id: int | None
