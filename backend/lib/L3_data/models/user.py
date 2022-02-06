#  Copyright (c) 2022. Alexandr Moroz

# from typing import TYPE_CHECKING

from sqlalchemy import Boolean, Column, String

from lib.L3_data.models.base_class import Base


class User(Base):
    full_name = Column(String, index=True)
    email = Column(String, unique=True, index=True, nullable=False)
    hashed_password = Column(String, nullable=False)
    is_active = Column(Boolean(), default=True)
    is_superuser = Column(Boolean(), default=False)
