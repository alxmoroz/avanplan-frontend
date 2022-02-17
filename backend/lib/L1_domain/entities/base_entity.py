#  Copyright (c) 2022. Alexandr Moroz

from pydantic import BaseModel


class BaseEntity(BaseModel):
    __abstract__ = True


class IdentifiableEntity(BaseEntity):
    __abstract__ = True

    id: int | None
