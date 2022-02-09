#  Copyright (c) 2022. Alexandr Moroz
from sqlalchemy import Column, DateTime, String, Integer

from ..base_model import BaseModel


class BaseTrackerFields:
    # __abstract__ = True

    code = Column(String, unique=True, index=True, nullable=False)
    title = Column(String, index=True)
    description = Column(String, index=True)


class ImportableFields:

    remote_code = Column(String)
    imported_on = Column(DateTime)
