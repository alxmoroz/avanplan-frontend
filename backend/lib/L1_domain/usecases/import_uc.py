#  Copyright (c) 2022. Alexandr Moroz
from ..entities.api import Msg
from ..entities.tracker import Project, Task, TaskPriority, TaskStatus
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
        task_priority_repo: AbstractDBRepo,
    ):
        self.import_repo = import_repo
        self.project_repo = project_repo
        self.task_repo = task_repo
        self.task_status_repo = task_status_repo
        self.task_priority_repo = task_priority_repo

    def _import_project(self, p: Project):
        p_in_db: Project = self.project_repo.get_one(remote_code=p.remote_code)

        if p_in_db:
            p.id = p_in_db.id
            self.project_repo.update(p)
        else:
            p = self.project_repo.create(p)

        for t in p.tasks:
            t.project_id = p.id
            self._import_task(t)

    def _import_task(self, t: Task):
        t.status_id = self._import_status(t.status).id
        t.priority_id = self._import_priority(t.priority).id

        t_in_db = self.task_repo.get_one(remote_code=t.remote_code)
        if t_in_db:
            t.id = t_in_db.id
            self.task_repo.update(t)
        else:
            self.task_repo.create(t)

    def _import_status(self, s: TaskStatus):
        s_in_db = self.task_status_repo.get_one(title=s.title)
        if s_in_db:
            # нет полей для обновления
            s.id = s_in_db.id
        else:
            self.task_status_repo.create(s)
        return s

    def _import_priority(self, tp: TaskPriority):
        tp_in_db: TaskPriority = self.task_priority_repo.get_one(title=tp.title)
        if tp_in_db:
            # нет полей для обновления
            tp.id = tp_in_db.id
        else:
            self.task_priority_repo.create(tp)
        return tp

    # TODO: флаги для рекурсивности, подзадач и т.п.
    def import_tasks(self):

        for p in self.import_repo.get_projects_with_tasks():
            self._import_project(p)

        return Msg(msg=f"Projects and tasks from {self.import_repo.source} imported successful")
