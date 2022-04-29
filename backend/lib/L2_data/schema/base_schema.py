#  Copyright (c) 2022. Alexandr Moroz

from abc import ABC
from datetime import datetime
from typing import Optional

from pydantic import BaseModel


class BaseSchema(BaseModel, ABC):
    class Config:
        orm_mode = True
        validate_assignment = True


class PKGetable(BaseSchema, ABC):
    id: int


class PKUpsertable(PKGetable, ABC):
    id: Optional[int]


class Timestampable(BaseSchema, ABC):
    created_on: datetime
    updated_on: datetime


class Titleable(BaseSchema, ABC):
    title: str


class Orderable(BaseSchema, ABC):
    order: int


# TODO: возможно, это нужно только для upsert схемы
class Importable(BaseSchema, ABC):
    remote_code: str


class Statusable(BaseSchema, ABC):
    closed: bool


class WorkspaceBounded(BaseSchema, ABC):
    workspace_id: int
