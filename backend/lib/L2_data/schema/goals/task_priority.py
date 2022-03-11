#  Copyright (c) 2022. Alexandr Moroz

from lib.L1_domain.entities import TaskPriority

from ..base_schema import BaseGetSchema, Identifiable, Orderable, Titleable


class TaskPrioritySchema(Identifiable, Titleable, Orderable, BaseGetSchema):
    def entity(self):
        return TaskPriority(**self.dict())
