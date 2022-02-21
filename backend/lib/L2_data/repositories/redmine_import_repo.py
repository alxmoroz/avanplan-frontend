#  Copyright (c) 2022. Alexandr Moroz

from datetime import datetime

from redminelib import Redmine
from redminelib.exceptions import BaseRedmineError

from lib.L1_domain.entities.api.exceptions import ApiException
from lib.L1_domain.entities.tracker import Project, Task, TaskStatus
from lib.L1_domain.repositories import AbstractImportRepo


class RedmineImportRepo(AbstractImportRepo):
    def __init__(self, host: str, api_key: str, version: str | None):

        if not host or not api_key:
            raise ApiException(400, "Host and API-key must be filled")

        self.source = f"Redmine {host}"
        self.redmine = Redmine(host, key=api_key, version=version)

    def get_projects_with_tasks(self) -> list[Project]:
        projects_with_tasks: list[Project] = []

        for rp in self.redmine.project.all():
            p: Project = Project(
                title=rp.name,
                description=rp.description,
                remote_code=f"{rp.id}",
                imported_on=datetime.now(),
            )
            try:
                p.tasks = [
                    Task(
                        title=issue.subject,
                        description=issue.description,
                        remote_code=f"{issue.id}",
                        imported_on=datetime.now(),
                        status=TaskStatus(title=f"{issue.status.name}")
                        # priority=TaskPriority(code=issue.priority.name),
                        # status=TaskStatus(code=issue.status.name),
                    )
                    for issue in rp.issues
                ]
            except BaseRedmineError:
                pass

            projects_with_tasks.append(p)

        return projects_with_tasks
