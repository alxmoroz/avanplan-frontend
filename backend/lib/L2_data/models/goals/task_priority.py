#  Copyright (c) 2022. Alexandr Moroz


from ..base_model import BaseModel, Orderable, TitleableUnique, WorkspaceBound


class TaskPriority(TitleableUnique, Orderable, WorkspaceBound, BaseModel):
    pass
