#  Copyright (c) 2022. Alexandr Moroz


from ..base_schema import Identifiable, Statusable, Titleable


class TaskStatusSchema(Identifiable, Titleable, Statusable):
    pass
