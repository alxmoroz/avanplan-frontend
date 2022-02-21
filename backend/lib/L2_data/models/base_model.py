#  Copyright (c) 2022. Alexandr Moroz

from sqlalchemy import Column, Integer
from sqlalchemy.ext.declarative import as_declarative, declared_attr

from lib.L1_domain.repositories import AbstractModel


@as_declarative()
class BaseModel(AbstractModel):
    __abstract__ = True

    id = Column(Integer, primary_key=True, index=True)

    # Generate __tablename__ automatically
    @declared_attr
    def __tablename__(cls) -> str:  # noqa
        return cls.__name__.lower() + "s"
