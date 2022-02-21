#  Copyright (c) 2022. Alexandr Moroz
from ..entities.api import Msg
from ..entities.tracker import Project, Task, TaskStatus
from ..repositories import AbstractDBRepo, AbstractImportRepo


# Универсальный юзкейс для импорта из любых источников
# TODO: обработка ошибок
class ImportUC:
    def __init__(
        self,
        import_repo: AbstractImportRepo,
        project_repo: AbstractDBRepo,
        task_repo: AbstractDBRepo,
        task_status_repo: AbstractDBRepo,
    ):
        self.import_repo = import_repo
        self.project_repo = project_repo
        self.task_repo = task_repo
        self.task_status_repo = task_status_repo

    # TODO: вытащить exclude в репы?
    def _import_project(self, p: Project):
        p_in_db: Project = self.project_repo.get_one(remote_code=p.remote_code)
        p_in = Project(**p.dict(exclude={"tasks"}))

        if p_in_db:
            p_in.id = p_in_db.id
            self.project_repo.update(p_in)
        else:
            p_in = self.project_repo.create(p_in)

        for t in p.tasks:
            t.project_id = p_in.id
            self._import_task(t)

    def _import_task(self, t: Task):
        t_in = Task(**t.dict(exclude={"status"}))
        t_in.status_id = self._import_status(t.status).id

        t_in_db = self.task_repo.get_one(remote_code=t.remote_code)
        if t_in_db:
            t_in.id = t_in_db.id
            self.task_repo.update(t_in)
        else:
            self.task_repo.create(t_in)

    def _import_status(self, s: TaskStatus):
        s_in_db = self.task_status_repo.get_one(title=s.title)
        if s_in_db:
            s.id = s_in_db.id
            self.task_status_repo.update(s)
        else:
            self.task_status_repo.create(s)
        return s

    # TODO: флаги для рекурсивности, подзадач и т.п.
    def import_tasks(self):

        for p in self.import_repo.get_projects_with_tasks():
            self._import_project(p)

        return Msg(msg=f"Projects and tasks from {self.import_repo.source} imported successful")
