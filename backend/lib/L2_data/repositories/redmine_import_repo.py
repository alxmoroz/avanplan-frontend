#  Copyright (c) 2022. Alexandr Moroz

from datetime import datetime

from redminelib import Redmine
from redminelib import resources as R

from lib.L1_domain.entities.api.exceptions import ApiException
from lib.L1_domain.entities.tracker import Person, Project, Task, TaskPriority, TaskStatus
from lib.L1_domain.repositories import AbstractImportRepo


class RedmineImportRepo(AbstractImportRepo):
    def __init__(self, host: str, api_key: str):

        if not host or not api_key:
            raise ApiException(400, "Host and API-key must be filled")

        self.source = f"Redmine {host}"
        self.redmine = Redmine(host, key=api_key)

        self.cached_r_projects: list[R.Project] | None = None
        self.remote_coded_projects_map: dict[int, Project] = {}

    @classmethod
    def _setup_person(cls, users: dict, resource, attr: str) -> Person | None:
        person = None
        r_user = getattr(resource, attr, None)
        if r_user:
            r_user = users[r_user.id]
            person = Person(
                firstname=r_user.firstname,
                lastname=r_user.lastname,
                remote_code=r_user.id,
                imported_on=datetime.now(),
            )
        return person

    @staticmethod
    def _set_parents(objects_map: dict):
        for obj in objects_map.values():
            obj._parent = objects_map.get(obj.parent_id, None)

    # по пустым запросам —> только открытые проекты и открытые задачи
    def _get_cached_r_projects(self) -> list[R.Project]:
        if not self.cached_r_projects:
            self.cached_r_projects = self.redmine.project.all()
        return self.cached_r_projects

    def get_projects(self) -> list[Project]:
        self.remote_coded_projects_map = {}
        self.cached_r_projects = None

        for r_project in self._get_cached_r_projects():
            parent_project = getattr(r_project, "parent", None)

            self.remote_coded_projects_map[r_project.id] = Project(
                title=r_project.name,
                description=r_project.description,
                remote_code=f"{r_project.id}",
                imported_on=datetime.now(),
                parent_id=parent_project.id if parent_project else None,
            )

        self._set_parents(self.remote_coded_projects_map)

        return list(self.remote_coded_projects_map.values())

    def get_tasks_tree(self) -> list[Task]:

        tasks: dict[int, Task] = {}

        r_issue_statuses = {st.id: st for st in self.redmine.issue_status.all()}
        r_users = {user.id: user for user in self.redmine.user.all()}

        if not self.cached_r_projects:
            self.get_projects()

        for r_project in self._get_cached_r_projects():

            for issue in r_project.issues if "issue_tracking" in r_project.enabled_modules else []:
                parent_issue = getattr(issue, "parent", None)
                task = Task(
                    title=issue.subject,
                    description=issue.description,
                    remote_code=f"{issue.id}",
                    imported_on=datetime.now(),
                    start_date=getattr(issue, "start_date", None),
                    due_date=getattr(issue, "due_date", None),
                    parent_id=parent_issue.id if parent_issue else None,
                )
                task._project = self.remote_coded_projects_map[r_project.id]
                r_issue_status = r_issue_statuses[issue.status.id]
                task._status = TaskStatus(title=f"{r_issue_status.name}", closed=r_issue_status.is_closed)
                task._priority = TaskPriority(title=f"{issue.priority.name}", order=issue.priority.id)
                task._author = self._setup_person(r_users, issue, "author")
                task._assigned_person = self._setup_person(r_users, issue, "assigned_to")

                tasks[issue.id] = task

        self._set_parents(tasks)

        return list(tasks.values())
