#  Copyright (c) 2022. Alexandr Moroz


from ..base_model import BaseModel, Orderable, TitleableUnique


class TaskPriority(TitleableUnique, Orderable, BaseModel):
    pass
