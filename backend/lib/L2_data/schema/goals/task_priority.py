#  Copyright (c) 2022. Alexandr Moroz

from ..base_schema import BaseSchema, Identifiable, Orderable, Titleable


class TaskPrioritySchema(Identifiable, Titleable, Orderable, BaseSchema):
    pass
