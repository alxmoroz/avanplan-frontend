#  Copyright (c) 2022. Alexandr Moroz

from sqlalchemy import Column, String, Integer

from .base import BaseTrackerFields, ImportableFields
from ..base_model import BaseModel


class Project(BaseModel, BaseTrackerFields, ImportableFields):
    pass
