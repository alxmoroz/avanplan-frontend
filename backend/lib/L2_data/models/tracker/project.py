#  Copyright (c) 2022. Alexandr Moroz
from sqlalchemy import Column, ForeignKey, Integer

from ..base_model import BaseModel
from .base import BaseTrackerFields, ImportableFields


class Project(BaseTrackerFields, ImportableFields, BaseModel):
    # tasks = relationship(
    #     "Task",
    #     # back_populates="project",
    #     cascade="all, delete",
    # )

    parent_id = Column(Integer, ForeignKey("projects.id", ondelete="CASCADE"))
