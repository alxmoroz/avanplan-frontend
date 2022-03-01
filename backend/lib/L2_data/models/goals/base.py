#  Copyright (c) 2022. Alexandr Moroz
from sqlalchemy import Boolean, Column, DateTime, String

from ..base_model import BaseModel


class TitledUnique:
    title = Column(String, unique=True)


class Importable:
    remote_code = Column(String)


class StatusableModel(TitledUnique, BaseModel):
    __abstract__ = True

    closed = Column(Boolean)


class SmartModel(Importable, BaseModel):
    __abstract__ = True

    title = Column(String, nullable=False)
    description = Column(String)
    due_date = Column(DateTime)
