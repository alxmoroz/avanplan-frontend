#  Copyright (c) 2022. Alexandr Moroz

from sqlalchemy import Boolean, Column, String

from ..base_model import BaseModel, Emailable


class User(Emailable, BaseModel):

    password = Column(String, nullable=False)
    full_name = Column(String, index=True)
    is_active = Column(Boolean())
    is_superuser = Column(Boolean())
