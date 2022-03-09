#  Copyright (c) 2022. Alexandr Moroz

from ..entities.goals import Goal, Task


class AbstractImportRepo:

    source: str

    @staticmethod
    def get_goals() -> list[Goal]:
        raise NotImplementedError

    @staticmethod
    def get_tasks_tree() -> list[Task]:
        raise NotImplementedError
