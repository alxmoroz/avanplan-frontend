#  Copyright (c) 2022. Alexandr Moroz

from datetime import datetime

from redminelib import Redmine
from redminelib import resources as R

from lib.L1_domain.entities.api.exceptions import ApiException
from lib.L1_domain.entities.tracker import Milestone, Person, Project, Task, TaskPriority, TaskStatus
from lib.L1_domain.repositories import AbstractImportRepo


class ImportRedmineRepo(AbstractImportRepo):
    def __init__(self, host: str, api_key: str):

        if not host or not api_key:
            raise ApiException(400, "Host and API-key must be filled")

        self.source = f"Redmine {host}"
        self.redmine = Redmine(host, key=api_key)

        self.cached_r_projects: list[R.Project] | None = None
        self.projects_map: dict[int, Project] = {}

    @staticmethod
    def _set_parents(objects_map: dict):
        for obj in objects_map.values():
            obj._parent = objects_map.get(obj.parent_id, None)

    def _get_persons(self) -> dict[int, Person]:
        return {
            user.id: Person(
                firstname=user.firstname,
                lastname=user.lastname,
                remote_code=user.id,
                imported_on=datetime.now(),
            )
            for user in self.redmine.user.all()
        }

    def _get_task_statuses(self) -> dict[int, TaskStatus]:
        return {
            st.id: TaskStatus(
                title=st.name,
                closed=st.is_closed,
            )
            for st in self.redmine.issue_status.all()
        }

    def _get_milestones_for_project(self, r_project: R.Project) -> dict[int, Milestone]:
        milestones = {}
        for version in r_project.versions:
            print(list(version))
            milestone = Milestone(
                title=version.name,
                description=version.description,
                remote_code=f"{version.id}",
                imported_on=datetime.now(),
                due_date=getattr(version, "due_date", None),
            )
            milestone._project = self.projects_map[r_project.id]
            milestones[version.id] = milestone

        return milestones

    # по пустым запросам —> только открытые проекты и открытые задачи
    def _get_cached_r_projects(self) -> list[R.Project]:
        if not self.cached_r_projects:
            self.cached_r_projects = self.redmine.project.all()
        return self.cached_r_projects

    def get_projects(self) -> list[Project]:
        self.projects_map = {}
        self.cached_r_projects = None

        for r_project in self._get_cached_r_projects():
            parent_project = getattr(r_project, "parent", None)

            self.projects_map[r_project.id] = Project(
                title=r_project.name,
                description=r_project.description,
                remote_code=f"{r_project.id}",
                imported_on=datetime.now(),
                parent_id=parent_project.id if parent_project else None,
            )

        self._set_parents(self.projects_map)

        return list(self.projects_map.values())

    def get_tasks_tree(self) -> list[Task]:

        tasks: dict[int, Task] = {}

        persons = self._get_persons()
        statuses = self._get_task_statuses()

        if not self.cached_r_projects:
            self.get_projects()

        for r_project in self._get_cached_r_projects():
            project = self.projects_map[r_project.id]

            if "issue_tracking" in r_project.enabled_modules:
                milestones = self._get_milestones_for_project(r_project)
                for issue in r_project.issues:
                    parent_issue = getattr(issue, "parent", None)
                    author = getattr(issue, "author", None)
                    assignee = getattr(issue, "assigned_to", None)
                    version = getattr(issue, "fixed_version", None)

                    task = Task(
                        parent_id=parent_issue.id if parent_issue else None,
                        title=issue.subject,
                        description=issue.description,
                        remote_code=f"{issue.id}",
                        imported_on=datetime.now(),
                        start_date=getattr(issue, "start_date", None),
                        due_date=getattr(issue, "due_date", None),
                    )
                    task._project = project
                    task._milestone = milestones[version.id] if version else None
                    task._status = statuses[issue.status.id]
                    task._priority = TaskPriority(title=f"{issue.priority.name}", order=issue.priority.id)
                    task._assignee = persons[assignee.id] if assignee else None
                    task._author = persons[author.id] if author else None

                    tasks[issue.id] = task

            self._set_parents(tasks)

        return list(tasks.values())
