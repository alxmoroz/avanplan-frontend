#  Copyright (c) 2022. Alexandr Moroz
from sqlalchemy.orm import relationship

from ..base_model import BaseModel
from .base import BaseTrackerFields, ImportableFields


class Project(BaseTrackerFields, ImportableFields, BaseModel):
    tasks = relationship(
        "Task",
        back_populates="project",
        cascade="all, delete",
    )
