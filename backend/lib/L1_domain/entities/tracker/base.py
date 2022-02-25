#  Copyright (c) 2022. Alexandr Moroz

from datetime import datetime

from pydantic import validator

from ..base_entity import BaseEntity, DBPersistEntity


class TrackerEntity(DBPersistEntity):
    __abstract__ = True

    title: str
    description: str | None


class Importable(BaseEntity):
    __abstract__ = True

    remote_code: str | None
    imported_on: datetime | None


class TimeBound(BaseEntity):
    __abstract__ = True

    start_date: datetime | None
    due_date: datetime | None


class Statusable(BaseEntity):
    __abstract__ = True

    closed: bool | None

    @classmethod
    @validator("closed")
    def closed_must_filled(cls, v):
        return v or False
