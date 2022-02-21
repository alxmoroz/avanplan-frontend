#  Copyright (c) 2022. Alexandr Moroz

from ..entities.tracker import Project


class AbstractImportRepo:
    __abstract__ = True

    source: str

    @staticmethod
    def get_projects_with_tasks() -> list[Project]:
        raise NotImplementedError
