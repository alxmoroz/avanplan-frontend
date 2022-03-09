#  Copyright (c) 2022. Alexandr Moroz

from ..base_model import BaseModel, Statusable, TitleableUnique


class GoalStatus(TitleableUnique, Statusable, BaseModel):
    pass
