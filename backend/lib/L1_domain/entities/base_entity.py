#  Copyright (c) 2022. Alexandr Moroz

from pydantic import BaseModel as PydanticModel

# TODO: есть шанс избавиться от зависимости Pydantic в Л1. Нужно определить место для валидаций на нижних уровнях и ура.


class BaseEntity(PydanticModel):
    __abstract__ = True


# TODO: перенести на Л2 - это общий класс для схем записи в БД


class DBPersistEntity(BaseEntity):
    __abstract__ = True

    id: int | None

    class Config:
        orm_mode = True
