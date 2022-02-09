#  Copyright (c) 2022. Alexandr Moroz

from sqlalchemy import Boolean, Column, String

from ..base_model import BaseModel


class User(BaseModel):

    full_name = Column(String, index=True)
    email = Column(String, unique=True, index=True, nullable=False)
    hashed_password = Column(String, nullable=False)
    is_active = Column(Boolean(), default=True)
    is_superuser = Column(Boolean(), default=False)
