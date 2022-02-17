#  Copyright (c) 2022. Alexandr Moroz

from ..entities.api import Msg
from ..entities.tracker import Project
from ..repositories import AbstractDBRepo, AbstractImportRepo


class ImportUC:
    def __init__(
        self,
        import_repo: AbstractImportRepo,
        project_repo: AbstractDBRepo,
        task_repo: AbstractDBRepo,
    ):
        self.import_repo = import_repo
        self.project_repo = project_repo
        self.task_repo = task_repo

    def import_redmine(self):

        for p in self.import_repo.get_projects():
            p_in_db: Project = self.project_repo.get_one(code=p.code)
            if p_in_db:
                p.id = p_in_db.id
                self.project_repo.update(p)
            else:
                self.project_repo.create(p)

        for t in self.import_repo.get_tasks():
            t_in_db = self.task_repo.get_one(code=t.code)
            if t_in_db:
                t.id = t_in_db.id
                self.task_repo.update(t)
            else:
                self.task_repo.create(t)

        return Msg(msg=f"Projects and tasks from {self.import_repo.source} imported successful")
