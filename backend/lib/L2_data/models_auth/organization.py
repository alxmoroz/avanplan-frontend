#  Copyright (c) 2022. Alexandr Moroz

from sqlalchemy import Column, String

from .base_model import BaseAuthModel


class Organization(BaseAuthModel):
    name = Column(String, unique=True, nullable=False)
