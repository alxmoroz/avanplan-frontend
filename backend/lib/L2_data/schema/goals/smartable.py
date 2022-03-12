#  Copyright (c) 2022. Alexandr Moroz

from abc import ABC
from datetime import datetime
from typing import Optional

from ..base_schema import Identifiable, Titleable


class Smartable(Titleable, Identifiable, ABC):
    description: Optional[str]
    due_date: Optional[datetime]
