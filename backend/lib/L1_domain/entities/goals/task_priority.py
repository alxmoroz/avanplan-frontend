#  Copyright (c) 2022. Alexandr Moroz

from dataclasses import dataclass

from ..base_entity import Orderable


@dataclass
class TaskPriority(Orderable):
    pass
