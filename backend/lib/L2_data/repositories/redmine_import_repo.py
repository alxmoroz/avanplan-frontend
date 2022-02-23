#  Copyright (c) 2022. Alexandr Moroz

from datetime import datetime

from redminelib import Redmine
from redminelib.exceptions import BaseRedmineError

from lib.L1_domain.entities.api.exceptions import ApiException
from lib.L1_domain.entities.tracker import Project, Task, TaskPriority, TaskStatus
from lib.L1_domain.repositories import AbstractImportRepo


class RedmineImportRepo(AbstractImportRepo):
    def __init__(self, host: str, api_key: str, version: str | None):

        if not host or not api_key:
            raise ApiException(400, "Host and API-key must be filled")

        self.source = f"Redmine {host}"
        self.redmine = Redmine(host, key=api_key, version=version)

    def get_projects_with_tasks(self) -> list[Project]:
        projects_with_tasks: list[Project] = []

        issue_statuses = {st.id: st for st in self.redmine.issue_status.all()}

        # по пустым запросам —> только открытые проекты и открытые задачи
        for rp in self.redmine.project.all():
            p: Project = Project(
                title=rp.name,
                description=rp.description,
                remote_code=f"{rp.id}",
                imported_on=datetime.now(),
            )
            try:
                tasks: list[Task] = []
                for issue in rp.issues:
                    t = Task(
                        title=issue.subject,
                        description=issue.description,
                        remote_code=f"{issue.id}",
                        imported_on=datetime.now(),
                    )

                    issue_status = issue_statuses[issue.status.id]
                    t.status = TaskStatus(title=f"{issue_status.name}", closed=issue_status.is_closed)
                    t.priority = TaskPriority(title=f"{issue.priority.name}", order=issue.priority.id)
                    tasks.append(t)

                p.tasks = tasks

            except BaseRedmineError as e:
                ApiException(400, str(e))

            projects_with_tasks.append(p)

        return projects_with_tasks
