#  Copyright (c) 2022. Alexandr Moroz
from dataclasses import dataclass

from ..base_entity import Identifiable, Orderable, Titleable


@dataclass
class TaskPriority(Identifiable, Titleable, Orderable):
    pass
