#  Copyright (c) 2022. Alexandr Moroz
from ..entities import RemoteTracker
from ..entities.goals.goal_import import GoalImport
from ..entities.goals.task_import import TaskImport


class AbstractImportRepo:

    tracker: RemoteTracker

    @staticmethod
    def get_goals() -> list[GoalImport]:
        raise NotImplementedError

    @staticmethod
    def get_tasks_tree(goals_ids: list[str]) -> list[TaskImport]:
        raise NotImplementedError
