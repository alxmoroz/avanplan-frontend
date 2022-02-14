#  Copyright (c) 2022. Alexandr Moroz

from pydantic import BaseModel


class BaseEntity(BaseModel):
    id: int | None
