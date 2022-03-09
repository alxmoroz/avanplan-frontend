#  Copyright (c) 2022. Alexandr Moroz
from datetime import datetime
from typing import Optional

from pydantic import BaseModel, validator


class BaseSchema(BaseModel):
    class Config:
        orm_mode = True
        validate_assignment = True


class Identifiable(BaseSchema):
    id: int | None = None


# TODO: для гет-схемы обязателен первый параметр, для создания не нужно это
class Timestampable(BaseSchema):
    created_on: Optional[datetime]
    updated_on: Optional[datetime]

    @validator("created_on", always=True)
    def created_date(cls, v):
        return v or datetime.now()


class Titleable(BaseSchema):
    title: str


class Orderable(BaseSchema):
    order: int

    @validator("order", always=True)
    def check_order(cls, v):
        return v or 0


class Importable(BaseSchema):
    remote_code: Optional[str]


class Statusable(BaseSchema):
    closed: Optional[bool]

    @validator("closed", always=True)
    def check_closed(cls, v):
        return v or False
