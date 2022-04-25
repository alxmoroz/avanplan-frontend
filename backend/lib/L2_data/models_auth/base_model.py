#  Copyright (c) 2022. Alexandr Moroz

from sqlalchemy import Column, Integer, String
from sqlalchemy.ext.declarative import as_declarative, declared_attr


@as_declarative()
class BaseAuthModel:
    __abstract__ = True

    id = Column(Integer, primary_key=True, index=True)

    @declared_attr
    def __tablename__(cls) -> str:  # noqa
        return cls.__name__.lower() + "s"


class Emailable:
    email = Column(String, unique=True, index=True, nullable=False)
