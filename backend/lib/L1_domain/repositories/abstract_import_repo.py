#  Copyright (c) 2022. Alexandr Moroz

from ..entities.tracker import Project, Task


class AbstractImportRepo:
    __abstract__ = True

    source: str

    @staticmethod
    def get_projects() -> list[Project]:
        raise NotImplementedError

    @staticmethod
    def get_tasks_tree() -> list[Task]:
        raise NotImplementedError
