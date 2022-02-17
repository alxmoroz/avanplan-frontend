#  Copyright (c) 2022. Alexandr Moroz

from datetime import datetime

from ..base_entity import BaseEntity, IdentifiableEntity


class BaseTrackerEntity(IdentifiableEntity):
    __abstract__ = True

    code: str
    title: str | None
    description: str | None


class Importable(BaseEntity):
    __abstract__ = True

    remote_code: str | None
    imported_on: datetime | None


class TimeBound(BaseEntity):
    __abstract__ = True

    start_date: datetime | None
    due_date: datetime | None
