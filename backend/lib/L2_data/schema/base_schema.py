#  Copyright (c) 2022. Alexandr Moroz

from abc import ABC
from datetime import datetime
from typing import Optional

from pydantic import BaseModel, validator


class BaseSchema(BaseModel, ABC):
    class Config:
        orm_mode = True
        validate_assignment = True


class Identifiable(BaseSchema, ABC):
    id: Optional[int]


# TODO: для гет-схемы обязателен первый параметр, для создания не нужно это
class Timestampable(BaseSchema, ABC):
    created_on: Optional[datetime]
    updated_on: Optional[datetime]

    @validator("created_on", always=True)
    def created_date(cls, v):
        return v or datetime.now()


class Titleable(BaseSchema, ABC):
    title: str


class Orderable(BaseSchema, ABC):
    order: int

    @validator("order", always=True)
    def check_order(cls, v):
        return v or 0


class Importable(BaseSchema, ABC):
    remote_code: Optional[str]


class Statusable(BaseSchema, ABC):
    closed: Optional[bool]

    @validator("closed", always=True)
    def check_closed(cls, v):
        return v or False
