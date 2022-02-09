#  Copyright (c) 2022. Alexandr Moroz

from datetime import datetime

from ..base_entity import BaseEntity


class BaseTrackerEntity(BaseEntity):
    code: str
    title: str = ""
    description: str = ""

    def __str__(self):
        return self.title


class ImportableEntity(BaseTrackerEntity):
    remote_code: str | None
    imported_on: datetime | None
