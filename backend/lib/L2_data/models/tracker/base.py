#  Copyright (c) 2022. Alexandr Moroz
from sqlalchemy import Boolean, Column, DateTime, String


class TrackerFields:
    title = Column(String)
    description = Column(String)


class ImportableFields:
    remote_code = Column(String)
    imported_on = Column(DateTime)


class TimeBoundFields:
    start_date = Column(DateTime)
    due_date = Column(DateTime)


class StatusFields:
    title = Column(String, unique=True)
    closed = Column(Boolean)
