#  Copyright (c) 2022. Alexandr Moroz

from datetime import datetime

from redminelib import Redmine, resources

from lib.L1_domain.entities.tracker import Project, Task
from lib.L1_domain.repositories import AbstractImportRepo


class RedmineImportRepo(AbstractImportRepo):
    def __init__(self, host: str, api_key: str, version: str | None):
        self.source = f"Redmine {host}"
        self.redmine = Redmine(host, key=api_key, version=version)

    def get_projects(self) -> list[Project]:
        r_opened_projects: list[resources.Project] = self.redmine.project.all()

        # TODO: попахивает мапперами)
        return [
            Project(
                code=rp.identifier,
                title=rp.name,
                description=rp.description,
                remote_code=f"R{rp.id}",
                imported_on=datetime.now(),
            )
            for rp in r_opened_projects
        ]

    def get_tasks(self) -> list[Task]:
        r_opened_issues: list[resources.Issue] = self.redmine.issue.filter(status_id="open")
        return [
            Task(
                code=issue.id,
                title=issue.subject,
                description=issue.description,
                remote_code=f"R{issue.id}",
                imported_on=datetime.now(),
                # priority=TaskPriority(code=issue.priority.name),
                # status=TaskStatus(code=issue.status.name),
            )
            for issue in r_opened_issues
        ]
