#  Copyright (c) 2022. Alexandr Moroz

from datetime import datetime

from pytz import utc
from redminelib import Redmine
from redminelib import resources as R

from lib.L1_domain.entities import Person, TaskPriority, TaskStatus
from lib.L1_domain.entities.api.exceptions import ApiException
from lib.L1_domain.entities.goals import GoalImport, TaskImport
from lib.L1_domain.repositories import AbstractImportRepo


class ImportRedmineRepo(AbstractImportRepo):
    def __init__(self, host: str, api_key: str):

        if not host or not api_key:
            raise ApiException(400, "Host and API-key must be filled")

        self.source = f"Redmine {host}"
        self.redmine = Redmine(host, key=api_key)

        self.cached_r_projects: list[R.Project] | None = None
        self.goals_map: dict[int, GoalImport] = {}

    @staticmethod
    def _set_parents(objects_map: dict[int, [TaskImport | GoalImport]]):
        for obj in objects_map.values():
            obj.parent = objects_map.get(getattr(obj, "remote_parent_id", None), None)

    def _get_persons(self) -> dict[int, Person]:
        return {
            user.id: Person(
                firstname=user.firstname,
                lastname=user.lastname,
                email=user.mail,
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

    # def _get_milestones_for_project(self, r_project: R.Project) -> dict[int, Milestone]:
    #     milestones = {}
    #     for version in r_project.versions:
    #         milestone = Milestone(
    #             title=version.name,
    #             description=version.description,
    #             remote_code=f"{version.id}",
    #             updated_on=datetime.now(tz=utc),
    #             due_date=getattr(version, "due_date", None),
    #             goal=self.goals_map[r_project.id],
    #         )
    #         milestones[version.id] = milestone
    #
    #     return milestones

    # по пустым запросам —> только открытые проекты и открытые задачи
    def _get_cached_r_projects(self) -> list[R.Project]:
        if not self.cached_r_projects:
            self.cached_r_projects = self.redmine.project.all()
        return self.cached_r_projects

    def get_goals(self) -> list[GoalImport]:
        self.goals_map = {}
        self.cached_r_projects = None

        for r_project in self._get_cached_r_projects():
            goal = GoalImport(
                title=r_project.name,
                description=r_project.description,
                updated_on=datetime.now(tz=utc),
                remote_code=f"{r_project.id}",
            )
            parent_project = getattr(r_project, "parent", None)
            goal.remote_parent_id = parent_project.id if parent_project else None
            self.goals_map[r_project.id] = goal

        self._set_parents(self.goals_map)

        return list(self.goals_map.values())

    def get_tasks_tree(self) -> list[TaskImport]:

        tasks: dict[int, TaskImport] = {}

        persons = self._get_persons()
        statuses = self._get_task_statuses()

        if not self.cached_r_projects:
            self.get_goals()

        for r_project in self._get_cached_r_projects():
            goal = self.goals_map[r_project.id]

            if "issue_tracking" in r_project.enabled_modules:
                # milestones = self._get_milestones_for_project(r_project)
                for issue in r_project.issues:

                    author = getattr(issue, "author", None)
                    assignee = getattr(issue, "assigned_to", None)
                    # version = getattr(issue, "fixed_version", None)

                    task = TaskImport(
                        goal=goal,
                        title=issue.subject,
                        description=issue.description,
                        due_date=getattr(issue, "due_date", None),
                        updated_on=datetime.now(tz=utc),
                        remote_code=f"{issue.id}",
                        status=statuses[issue.status.id],
                        priority=TaskPriority(title=f"{issue.priority.name}", order=issue.priority.id),
                        assignee=persons[assignee.id] if assignee else None,
                        author=persons[author.id] if author else None,
                    )

                    parent_issue = getattr(issue, "parent", None)
                    task.remote_parent_id = parent_issue.id if parent_issue else None

                    tasks[issue.id] = task

            self._set_parents(tasks)

        return list(tasks.values())
