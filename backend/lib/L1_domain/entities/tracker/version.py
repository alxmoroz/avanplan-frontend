#  Copyright (c) 2022. Alexandr Moroz
from datetime import datetime

from .base_tracker import BaseTrackerEntity, ImportableEntity


class Status(BaseTrackerEntity):
    pass


class Version(ImportableEntity):
    status: Status
    start_date: datetime | None
    due_date: datetime | None

    class Config:
        orm_mode = True
