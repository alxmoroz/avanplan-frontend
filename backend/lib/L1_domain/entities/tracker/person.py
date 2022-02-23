#  Copyright (c) 2022. Alexandr Moroz

from ..base_entity import DBPersistEntity
from .base_tracker import Importable


class Person(DBPersistEntity, Importable):
    firstname: str | None
    lastname: str | None

    # TODO: валидация на пустые поля. Чтобы хоть что-то заполнено было...
