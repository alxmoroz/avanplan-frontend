#  Copyright (c) 2022. Alexandr Moroz
from typing import Optional

from .smartable import Smartable


class TaskSchema(Smartable):
    goal_id: int
    parent_id: Optional[int]
    status_id: Optional[int]
    priority_id: Optional[int]
    assignee_id: Optional[int]
    author_id: Optional[int]
    # TODO: не получается из базы наполнить...
    # status: Optional[TaskStatusSchema]
