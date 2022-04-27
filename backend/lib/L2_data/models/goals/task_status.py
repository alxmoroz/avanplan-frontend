#  Copyright (c) 2022. Alexandr Moroz

from ..base_model import BaseModel, Statusable, TitleableUnique, WorkspaceBound


class TaskStatus(TitleableUnique, Statusable, WorkspaceBound, BaseModel):
    pass
