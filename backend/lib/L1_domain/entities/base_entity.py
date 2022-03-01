#  Copyright (c) 2022. Alexandr Moroz
from datetime import datetime
from typing import Optional

from pydantic import BaseModel as PydanticModel
from pydantic import validator

# TODO: есть шанс избавиться от зависимости Pydantic в Л1. Нужно определить место для валидаций на нижних уровнях и ура.


class BaseEntity(PydanticModel):
    pass


# TODO: перенести на Л2 - это общий класс для схем записи в БД


class DBPersistent(BaseEntity):

    id: Optional[int]
    created_on: Optional[datetime]
    updated_on: Optional[datetime]

    @validator("created_on", always=True)
    def created_date(cls, v):
        return v or datetime.now()

    class Config:
        orm_mode = True
        validate_assignment = True
        underscore_attrs_are_private = True
