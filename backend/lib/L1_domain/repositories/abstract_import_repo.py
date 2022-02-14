#  Copyright (c) 2022. Alexandr Moroz

from lib.L1_domain.entities.tracker import Project, Task


class AbstractImportRepo:
    __abstract__ = True

    source: str

    @staticmethod
    def get_projects() -> list[Project]:
        raise NotImplementedError

    @staticmethod
    def get_tasks() -> list[Task]:
        raise NotImplementedError
