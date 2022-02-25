#  Copyright (c) 2022. Alexandr Moroz
from sqlalchemy import Column, ForeignKey, Integer

from ..base_model import BaseModel
from .base import ImportableFields, StatusFields, TrackerFields


class ProjectStatus(TrackerFields, StatusFields, BaseModel):
    pass


class Project(TrackerFields, ImportableFields, BaseModel):
    # tasks = relationship(
    #     "Task",
    #     # back_populates="project",
    #     cascade="all, delete",
    # )

    parent_id = Column(Integer, ForeignKey("projects.id", ondelete="CASCADE"))

    status_id = Column(Integer, ForeignKey("projectstatuss.id"))
