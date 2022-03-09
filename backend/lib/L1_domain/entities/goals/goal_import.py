#  Copyright (c) 2022. Alexandr Moroz
from __future__ import annotations

from dataclasses import dataclass

from .goal import Goal


# TODO: наверное, это должно быть в репозитории импорта и отдельная схема просто. Такая сущность это не ок
# TODO: может, лучше со схемами работать? Тогда ещё подумать как их протаскивать в юзкейс Л1
@dataclass
class GoalImport(Goal):
    parent: GoalImport | None = None
