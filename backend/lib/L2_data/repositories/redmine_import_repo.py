#  Copyright (c) 2022. Alexandr Moroz

from datetime import datetime

from redminelib import Redmine

from lib.L1_domain.entities.api.exceptions import ApiException
from lib.L1_domain.entities.tracker import Person, Project, Task, TaskPriority, TaskStatus
from lib.L1_domain.repositories import AbstractImportRepo


class RedmineImportRepo(AbstractImportRepo):
    def __init__(self, host: str, api_key: str, version: str | None):

        if not host or not api_key:
            raise ApiException(400, "Host and API-key must be filled")

        self.source = f"Redmine {host}"
        self.redmine = Redmine(host, key=api_key, version=version)

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

    def get_projects_with_tasks(self) -> list[Project]:
        projects_with_tasks: list[Project] = []

        r_issue_statuses = {st.id: st for st in self.redmine.issue_status.all()}
        r_users = {user.id: user for user in self.redmine.user.all()}

        # по пустым запросам —> только открытые проекты и открытые задачи
        for rp in self.redmine.project.all():
            p: Project = Project(
                title=rp.name,
                description=rp.description,
                remote_code=f"{rp.id}",
                imported_on=datetime.now(),
            )

            tasks: list[Task] = []
            for issue in rp.issues if "issue_tracking" in rp.enabled_modules else []:
                task = Task(
                    title=issue.subject,
                    description=issue.description,
                    remote_code=f"{issue.id}",
                    imported_on=datetime.now(),
                )

                r_issue_status = r_issue_statuses[issue.status.id]
                task._status = TaskStatus(title=f"{r_issue_status.name}", closed=r_issue_status.is_closed)
                task._priority = TaskPriority(title=f"{issue.priority.name}", order=issue.priority.id)
                task._author = self._setup_person(r_users, issue, "author")
                task._assigned_person = self._setup_person(r_users, issue, "assigned_to")

                task.start_date = getattr(issue, "start_date", None)
                task.due_date = getattr(issue, "due_date", None)

                parent_issue = getattr(issue, "parent", None)
                task._parent = parent_issue.id if parent_issue else None

                tasks.append(task)

            remote_coded_tasks = {int(t.remote_code): t for t in tasks}
            for task in tasks:
                if task.parent:
                    # TODO: здесь только задачи текущего проекта
                    task._parent = remote_coded_tasks.get(task.parent, None)

            p._tasks = tasks

            projects_with_tasks.append(p)

        return projects_with_tasks
