#  Copyright (c) 2022. Alexandr Moroz
from datetime import date, datetime

from redminelib import Redmine
from redminelib import resources as r

from lib.L1_domain.entities import Person, RemoteTracker, TaskPriority, TaskStatus
from lib.L1_domain.entities.goals import GoalImport, TaskImport
from lib.L1_domain.repositories import AbstractImportRepo


class ImportRedmineRepo(AbstractImportRepo):
    def __init__(self, tracker: RemoteTracker):

        self.tracker = tracker
        self._r_projects: list[r.Project] | None = None
        self._goals_map: dict[int, GoalImport] = {}
        self._redmine = None
        self._persons = None

    @property
    def redmine(self):
        # TODO: добавить вариант с обычной авторизацией
        if not self._redmine:
            self._redmine = Redmine(self.tracker.url, key=self.tracker.login_key)
        return self._redmine

    @property
    def r_projects(self) -> list[r.Project]:
        if not self._r_projects:
            self._r_projects = self.redmine.project.all()
        return self._r_projects

    @staticmethod
    def _set_parents(objects_map: dict[int, [TaskImport | GoalImport]]):
        for obj in objects_map.values():
            obj.parent = objects_map.get(getattr(obj, "remote_parent_id", None), None)

    @staticmethod
    def _person_from_user(r_user: r.User) -> Person:
        return Person(
            firstname=r_user.firstname,
            lastname=r_user.lastname,
            email=getattr(r_user, "mail", f"{r_user.firstname}{r_user.lastname}@none.none"),
        )

    @staticmethod
    def _dt_from_attr(data: date | datetime | None) -> datetime:
        return datetime(year=data.year, month=data.month, day=data.day) if data else None

    @property
    def persons(self) -> dict[int, Person]:
        if not self._persons:
            r_users = [u for u in self.redmine.user.filter(status=1)]
            r_users += [u for u in self.redmine.user.filter(status=3)]
            self._persons = {user.id: self._person_from_user(user) for user in r_users}
        return self._persons

    def _get_person_fallback(self, user_id: int) -> Person | None:
        p = None
        if user_id:
            p = self.persons.get(user_id, None)
            if not p:
                r_user = self.redmine.user.get(user_id)
                if r_user:
                    p = self._person_from_user(r_user)
        return p

    def _get_task_statuses(self) -> dict[int, TaskStatus]:
        return {
            st.id: TaskStatus(
                title=st.name,
                closed=st.is_closed,
            )
            for st in self.redmine.issue_status.all()
        }

    # def _get_milestones_for_project(self, r_project: r.Project) -> dict[int, Milestone]:
    #     milestones = {}
    #     for version in r_project.versions:
    #         milestone = Milestone(
    #             title=version.name,
    #             description=version.description,
    #             remote_code=f"{version.id}",
    #             updated_on=datetime.now(tz=utc),
    #             due_date=getattr(version, "due_date", None),
    #             goal=self._goals_map[r_project.id],
    #         )
    #         milestones[version.id] = milestone
    #
    #     return milestones

    # по пустым запросам —> только открытые проекты и открытые задачи

    def get_goals(self) -> list[GoalImport]:

        for r_project in self.r_projects:
            goal = GoalImport(
                title=r_project.name,
                description=r_project.description,
                created_on=self._dt_from_attr(getattr(r_project, "created_on", None)),
                updated_on=self._dt_from_attr(getattr(r_project, "updated_on", None)),
                remote_code=f"{r_project.id}",
            )
            parent_project = getattr(r_project, "parent", None)
            goal.remote_parent_id = parent_project.id if parent_project else None
            self._goals_map[r_project.id] = goal

        self._set_parents(self._goals_map)

        return list(self._goals_map.values())

    def get_tasks_tree(self, goals_ids: list[str]) -> list[TaskImport]:

        tasks: dict[int, TaskImport] = {}
        statuses = self._get_task_statuses()

        for r_project in [rp for rp in self.r_projects if f"{rp.id}" in goals_ids]:
            goal = self._goals_map[r_project.id]

            if "issue_tracking" in r_project.enabled_modules:
                # milestones = self._get_milestones_for_project(r_project)
                for issue in self.redmine.issue.filter(status_id="*", project_id=r_project.id):

                    r_author = getattr(issue, "author", None)
                    author = self._get_person_fallback(r_author.id) if r_author else None

                    r_assignee = getattr(issue, "assigned_to", None)
                    assignee = self._get_person_fallback(r_assignee.id) if r_assignee else None
                    # version = getattr(issue, "fixed_version", None)

                    status = statuses[issue.status.id]

                    task = TaskImport(
                        created_on=self._dt_from_attr(getattr(issue, "created_on", None)),
                        updated_on=self._dt_from_attr(getattr(issue, "updated_on", None)),
                        goal=goal,
                        title=issue.subject,
                        description=issue.description,
                        due_date=self._dt_from_attr(getattr(issue, "due_date", None)),
                        remote_code=f"{issue.id}",
                        status=status,
                        closed=status.closed,
                        priority=TaskPriority(title=f"{issue.priority.name}", order=issue.priority.id),
                        assignee=assignee,
                        author=author,
                    )

                    parent_issue = getattr(issue, "parent", None)
                    task.remote_parent_id = parent_issue.id if parent_issue else None

                    tasks[issue.id] = task

            self._set_parents(tasks)

        return list(tasks.values())
