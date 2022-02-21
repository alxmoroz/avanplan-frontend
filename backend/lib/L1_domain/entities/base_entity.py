#  Copyright (c) 2022. Alexandr Moroz

from pydantic import BaseModel


class BaseEntity(BaseModel):
    __abstract__ = True


class DBPersistEntity(BaseEntity):
    __abstract__ = True

    id: int | None

    class Config:
        orm_mode = True
