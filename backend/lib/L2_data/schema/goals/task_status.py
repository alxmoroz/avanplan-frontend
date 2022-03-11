#  Copyright (c) 2022. Alexandr Moroz

from lib.L1_domain.entities import TaskStatus

from ..base_schema import BaseGetSchema, Identifiable, Statusable, Titleable


class TaskStatusSchema(Identifiable, Titleable, Statusable, BaseGetSchema):
    def entity(self):
        return TaskStatus(**self.dict())
