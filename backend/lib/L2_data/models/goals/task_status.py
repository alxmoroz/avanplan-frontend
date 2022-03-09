#  Copyright (c) 2022. Alexandr Moroz

from ..base_model import BaseModel, Statusable, TitleableUnique


class TaskStatus(TitleableUnique, Statusable, BaseModel):
    pass
