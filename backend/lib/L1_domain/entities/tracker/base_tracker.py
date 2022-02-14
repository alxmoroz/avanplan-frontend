#  Copyright (c) 2022. Alexandr Moroz

from datetime import datetime

from ..base_entity import BaseEntity


class BaseTrackerEntity(BaseEntity):
    code: str
    title: str | None
    description: str | None


class Importable(BaseEntity):
    remote_code: str | None
    imported_on: datetime | None


class TimeBound(BaseEntity):
    start_date: datetime | None
    due_date: datetime | None
