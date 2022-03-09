#  Copyright (c) 2022. Alexandr Moroz
from typing import Optional

from .smartable import Smartable


class GoalSchema(Smartable):
    parent_id: Optional[int]
    status_id: Optional[int]
