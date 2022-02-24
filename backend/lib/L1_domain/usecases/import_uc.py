#  Copyright (c) 2022. Alexandr Moroz

from ..entities.api import Msg
from ..entities.base_entity import DBPersistEntity
from ..entities.tracker import Person, Project, Task, TaskPriority, TaskStatus
from ..repositories import AbstractDBRepo, AbstractImportRepo


# TODO: обработка ошибок
# Универсальный юзкейс для импорта из любых источников
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

    @classmethod
    def _import_reference_resource(
        cls,
        e: DBPersistEntity,
        key: str,
        processed_dict: dict,
        repo: AbstractDBRepo,
        **filter_by,
    ) -> int | None:
        if key not in processed_dict:
            processed_dict[key] = repo.upsert(e, **filter_by)
        return processed_dict[key].id

    def _import_project(self, project: Project):
        project = self.project_repo.upsert(project, remote_code=project.remote_code)

        for task in project.tasks:
            task.project_id = project.id
            self._import_task(task)

    def _import_task(self, task: Task):
        task.status_id = self._import_status(task.status)
        task.priority_id = self._import_priority(task.priority)
        task.assigned_person_id = self._import_person(task.assigned_person)
        task.author_id = self._import_person(task.author)

        self.task_repo.upsert(task, remote_code=task.remote_code)

    def _import_status(self, status: TaskStatus) -> int | None:
        if status:
            return self._import_reference_resource(
                status,
                status.title,
                self.processed_statuses,
                self.task_status_repo,
                title=status.title,
            )

    def _import_priority(self, priority: TaskPriority) -> int | None:
        if priority:
            return self._import_reference_resource(
                priority,
                priority.title,
                self.processed_priorities,
                self.task_priority_repo,
                title=priority.title,
            )

    def _import_person(self, person: Person) -> int | None:
        if person:
            return self._import_reference_resource(
                person,
                person.remote_code,
                self.processed_persons,
                self.person_repo,
                remote_code=person.remote_code,
            )

    def import_tasks(self):

        self._reset_processed()

        for project in self.import_repo.get_projects_with_tasks():
            self._import_project(project)

        return Msg(msg=f"Projects and tasks from {self.import_repo.source} imported successful")
