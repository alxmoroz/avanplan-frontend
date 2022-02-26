#  Copyright (c) 2022. Alexandr Moroz

from ..entities.api import Msg
from ..entities.base_entity import DBPersistEntity
from ..entities.tracker import Goal, Milestone, Person, Task, TaskPriority, TaskStatus
from ..repositories import AbstractDBRepo, AbstractImportRepo


# TODO: обработка ошибок
# Универсальный юзкейс для импорта из любых источников
class ImportUC:
    def __init__(
        self,
        import_repo: AbstractImportRepo,
        goal_repo: AbstractDBRepo,
        task_repo: AbstractDBRepo,
        task_status_repo: AbstractDBRepo,
        task_priority_repo: AbstractDBRepo,
        person_repo: AbstractDBRepo,
        milestone_repo: AbstractDBRepo,
    ):
        self.import_repo = import_repo
        self.goal_repo = goal_repo
        self.task_repo = task_repo
        self.task_status_repo = task_status_repo
        self.task_priority_repo = task_priority_repo
        self.person_repo = person_repo
        self.milestone_repo = milestone_repo

    def _reset_processed(self):
        self.processed_goals = {}
        self.processed_tasks = {}
        self.processed_task_statuses = {}
        self.processed_persons = {}
        self.processed_priorities = {}
        self.processed_milestones = {}

    @classmethod
    def _upsert_once(
        cls,
        e: DBPersistEntity,
        key: str,
        processed_dict: dict,
        repo: AbstractDBRepo,
        **filter_by,
    ) -> int:
        if key not in processed_dict:
            processed_dict[key] = repo.upsert(e, **filter_by)
        return processed_dict[key].id

    def _upsert_goal(self, goal: Goal) -> int | None:
        if goal:
            goal.parent_id = self._upsert_goal(goal.parent)

            return self._upsert_once(
                goal,
                goal.remote_code,
                self.processed_goals,
                self.goal_repo,
                remote_code=goal.remote_code,
            )

    def _upsert_milestone(self, milestone: Milestone) -> int | None:
        if milestone:
            milestone.goal_id = self._upsert_goal(milestone.goal)
            return self._upsert_once(
                milestone,
                milestone.remote_code,
                self.processed_milestones,
                self.milestone_repo,
                remote_code=milestone.remote_code,
            )

    def _upsert_task(self, task: Task) -> int | None:
        if task:
            task.goal_id = self._upsert_goal(task.goal)
            task.milestone_id = self._upsert_milestone(task.milestone)
            task.status_id = self._upsert_status(task.status)
            task.priority_id = self._upsert_priority(task.priority)
            task.assignee_id = self._upsert_person(task.assigned_person)
            task.author_id = self._upsert_person(task.author)
            task.parent_id = self._upsert_task(task.parent)

            return self._upsert_once(
                task,
                task.remote_code,
                self.processed_tasks,
                self.task_repo,
                remote_code=task.remote_code,
            )

    def _upsert_status(self, status: TaskStatus) -> int | None:
        if status:
            return self._upsert_once(
                status,
                status.title,
                self.processed_task_statuses,
                self.task_status_repo,
                title=status.title,
            )

    def _upsert_priority(self, priority: TaskPriority) -> int | None:
        if priority:
            return self._upsert_once(
                priority,
                priority.title,
                self.processed_priorities,
                self.task_priority_repo,
                title=priority.title,
            )

    def _upsert_person(self, person: Person) -> int | None:
        if person:
            return self._upsert_once(
                person,
                person.remote_code,
                self.processed_persons,
                self.person_repo,
                remote_code=person.remote_code,
            )

    def import_goals(self) -> Msg:
        self._reset_processed()
        for goal in self.import_repo.get_goals():
            self._upsert_goal(goal)

        return Msg(msg=f"Goals from {self.import_repo.source} imported successful")

    def import_tasks(self) -> Msg:
        self._reset_processed()
        for task in self.import_repo.get_tasks_tree():
            self._upsert_task(task)

        return Msg(msg=f"Tasks with goals from {self.import_repo.source} imported successful")
