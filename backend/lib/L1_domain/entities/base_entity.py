#  Copyright (c) 2022. Alexandr Moroz

from pydantic import BaseModel as PydanticModel


class BaseEntity(PydanticModel):
    __abstract__ = True

    class Config:
        validate_assignment = True


class DBPersistEntity(BaseEntity):
    __abstract__ = True

    id: int | None

    class Config:
        orm_mode = True
        underscore_attrs_are_private = True
