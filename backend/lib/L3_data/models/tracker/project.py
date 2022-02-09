#  Copyright (c) 2022. Alexandr Moroz


from ..base_model import BaseModel
from .base import BaseTrackerFields, ImportableFields


class Project(BaseModel, BaseTrackerFields, ImportableFields):
    pass
