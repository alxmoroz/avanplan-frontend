#  Copyright (c) 2022. Alexandr Moroz

from abc import ABC
from datetime import date, datetime
from typing import Optional

from ..base_schema import Identifiable, Importable, Timestampable, Titleable


class Smartable(Timestampable, Titleable, Importable, Identifiable, ABC):
    description: Optional[str]
    due_date: Optional[datetime | date]
