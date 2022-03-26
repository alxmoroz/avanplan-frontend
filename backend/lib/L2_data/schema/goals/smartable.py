#  Copyright (c) 2022. Alexandr Moroz

from abc import ABC
from datetime import datetime
from typing import Optional

from ..base_schema import Titleable


class Smartable(Titleable, ABC):
    description: Optional[str]
    due_date: Optional[datetime]
    parent_id: Optional[int]
    closed: bool
