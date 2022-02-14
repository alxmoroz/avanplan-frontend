#  Copyright (c) 2022. Alexandr Moroz
from sqlalchemy import Column, DateTime, String


class BaseTrackerFields:
    code = Column(String, unique=True, index=True, nullable=False)
    title = Column(String, index=True)
    description = Column(String, index=True)


class ImportableFields:
    remote_code = Column(String)
    imported_on = Column(DateTime)


class TimeBoundFields:
    start_date = Column(DateTime)
    due_date = Column(DateTime)
