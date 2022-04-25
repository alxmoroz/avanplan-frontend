#  Copyright (c) 2022. Alexandr Moroz

from sqlalchemy import Boolean, Column, ForeignKey, Integer, String
from sqlalchemy.orm import relationship

from .base_model import BaseAuthModel, Emailable


class User(Emailable, BaseAuthModel):

    password = Column(String, nullable=False)
    full_name = Column(String, index=True)
    is_active = Column(Boolean())
    is_superuser = Column(Boolean())
    organization_id = Column(Integer, ForeignKey("organizations.id", ondelete="CASCADE"))
    organization = relationship("Organization")
