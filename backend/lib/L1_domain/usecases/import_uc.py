#  Copyright (c) 2022. Alexandr Moroz
from ..entities.api import Msg
from ..entities.tracker import Person, Project, Task, TaskPriority, TaskStatus
from ..repositories import AbstractDBRepo, AbstractImportRepo

# TODO: сложновато выглядит. Может, разнести, декомпозировать?


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
        person_repo: AbstractDBRepo,
    ):
        self.import_repo = import_repo
        self.project_repo = project_repo
        self.task_repo = task_repo
        self.task_status_repo = task_status_repo
        self.task_priority_repo = task_priority_repo
        self.person_repo = person_repo

    def _reset_processed(self):
        self.processed_statuses = {}
        self.processed_persons = {}
        self.processed_priorities = {}

    def _import_project(self, p: Project):
        p_in_db: Project = self.project_repo.get_one(remote_code=p.remote_code)

        if p_in_db:
            p.id = p_in_db.id
            self.project_repo.update(p)
        else:
            p = self.project_repo.create(p)

        for task in p.tasks:
            task.project_id = p.id
            self._import_task(task)

    def _import_task(self, task: Task):
        task.status_id = self._import_status(task.status)
        task.priority_id = self._import_priority(task.priority)
        task.assigned_person_id = self._import_person(task.assigned_person)
        task.author_id = self._import_person(task.author)

        t_in_db = self.task_repo.get_one(remote_code=task.remote_code)
        if t_in_db:
            task.id = t_in_db.id
            self.task_repo.update(task)
        else:
            self.task_repo.create(task)

    def _import_status(self, st: TaskStatus) -> int:
        if st.title not in self.processed_statuses:
            st_in_db = self.task_status_repo.get_one(title=st.title)
            if st_in_db:
                # нет полей для обновления
                st.id = st_in_db.id
            else:
                st = self.task_status_repo.create(st)
            self.processed_statuses[st.title] = 1

        return st.id

    def _import_priority(self, tp: TaskPriority) -> int:
        if tp.title not in self.processed_priorities:
            tp_in_db: TaskPriority = self.task_priority_repo.get_one(title=tp.title)
            if tp_in_db:
                # нет полей для обновления
                tp.id = tp_in_db.id
            else:
                tp = self.task_priority_repo.create(tp)
            self.processed_priorities[tp.title] = 1

        return tp.id

    def _import_person(self, person: Person) -> int | None:

        if person:
            if person.remote_code not in self.processed_persons:
                person_in_db: Person = self.person_repo.get_one(remote_code=person.remote_code)
                if person_in_db:
                    person.id = person_in_db.id
                    self.person_repo.update(person)
                else:
                    person = self.person_repo.create(person)
                self.processed_persons[person.remote_code] = 1
            return person.id

    def import_tasks(self):

        self._reset_processed()

        for project in self.import_repo.get_projects_with_tasks():
            self._import_project(project)

        return Msg(msg=f"Projects and tasks from {self.import_repo.source} imported successful")
