#  Copyright (c) 2022. Alexandr Moroz

from ..entities.goals.goal_import import GoalImport
from ..entities.goals.task_import import TaskImport


class AbstractImportRepo:

    # TODO: источник импорта для всей репы...
    source: str

    @staticmethod
    def get_goals() -> list[GoalImport]:
        raise NotImplementedError

    @staticmethod
    def get_tasks_tree() -> list[TaskImport]:
        raise NotImplementedError
