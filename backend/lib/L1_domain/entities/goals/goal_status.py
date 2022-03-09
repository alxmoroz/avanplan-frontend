#  Copyright (c) 2022. Alexandr Moroz
from dataclasses import dataclass

from ..base_entity import Identifiable, Statusable, Titleable


@dataclass
class GoalStatus(Identifiable, Titleable, Statusable):
    pass
