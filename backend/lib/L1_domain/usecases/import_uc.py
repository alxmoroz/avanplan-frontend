#  Copyright (c) 2022. Alexandr Moroz

from ..entities.api import Msg
from ..entities.goals import Person, Task, TaskPriority, TaskStatus
from ..entities.goals.goal_import import GoalImport
from ..entities.goals.task_import import TaskImport
from ..repositories import AbstractDBRepo, AbstractImportRepo
from ..repositories.abstract_entity_repo import AbstractEntityRepo, E


# TODO: обработка ошибок
# Универсальный юзкейс для импорта из любых источников
class ImportUC:
    def __init__(
        self,
        import_repo: AbstractImportRepo,
        goal_repo: AbstractDBRepo,
        goal_e_repo: AbstractEntityRepo,
        task_repo: AbstractDBRepo,
        task_e_repo: AbstractEntityRepo,
        task_status_repo: AbstractDBRepo,
        task_status_e_repo: AbstractEntityRepo,
        task_priority_repo: AbstractDBRepo,
        task_priority_e_repo: AbstractEntityRepo,
        person_repo: AbstractDBRepo,
        person_e_repo: AbstractEntityRepo,
    ):
        self.import_repo = import_repo
        self.goal_repo = goal_repo
        self.goal_e_repo = goal_e_repo
        self.task_repo = task_repo
        self.task_e_repo = task_e_repo
        self.task_status_repo = task_status_repo
        self.task_status_e_repo = task_status_e_repo
        self.task_priority_repo = task_priority_repo
        self.task_priority_e_repo = task_priority_e_repo
        self.person_repo = person_repo
        self.person_e_repo = person_e_repo

    def _reset_processed(self):
        self.processed_goals = {}
        self.processed_tasks = {}
        self.processed_task_statuses = {}
        self.processed_persons = {}
        self.processed_priorities = {}

    @classmethod
    def _upsert_once(
        cls,
        e: E,
        key: str,
        processed_dict: dict,
        db_repo: AbstractDBRepo,
        e_repo: AbstractEntityRepo,
        **filter_by,
    ) -> E:
        if key not in processed_dict:
            db_obj = db_repo.get_one(**filter_by)
            schema_create = e_repo.schema_create_from_entity(e)
            schema_create.id = db_obj.id if db_obj else None
            data = e_repo.dict_from_schema_create(schema_create)
            e = e_repo.entity_from_orm(db_repo.update(data))
            processed_dict[key] = e
        return processed_dict[key]

    def _upsert_goal(self, goal: GoalImport) -> GoalImport:
        if goal:
            goal.parent = self._upsert_goal(goal.parent)
            return self._upsert_once(
                goal,
                goal.remote_code,
                self.processed_goals,
                self.goal_repo,
                self.goal_e_repo,
                remote_code=goal.remote_code,
            )

    # def _upsert_milestone(self, milestone: Milestone) -> Milestone:
    #     if milestone:
    #         milestone.goal = self._upsert_goal(milestone.goal)
    #         return self._upsert_once(
    #             milestone,
    #             milestone.remote_code,
    #             self.processed_milestones,
    #             self.milestone_repo,
    #             remote_code=milestone.remote_code,
    #         )

    def _upsert_task(self, task: TaskImport) -> Task:
        if task:
            task.goal = self._upsert_goal(task.goal)
            task.status = self._upsert_status(task.status)
            task.priority = self._upsert_priority(task.priority)
            task.assignee = self._upsert_person(task.assignee)
            task.author = self._upsert_person(task.author)
            task.parent = self._upsert_task(task.parent)

            return self._upsert_once(
                task,
                task.remote_code,
                self.processed_tasks,
                self.task_repo,
                self.task_e_repo,
                remote_code=task.remote_code,
            )

    def _upsert_status(self, status: TaskStatus) -> TaskStatus:
        if status:
            return self._upsert_once(
                status,
                status.title,
                self.processed_task_statuses,
                self.task_status_repo,
                self.task_status_e_repo,
                title=status.title,
            )

    def _upsert_priority(self, priority: TaskPriority) -> TaskPriority:
        if priority:
            return self._upsert_once(
                priority,
                priority.title,
                self.processed_priorities,
                self.task_priority_repo,
                self.task_priority_e_repo,
                title=priority.title,
            )

    def _upsert_person(self, person: Person) -> Person:
        if person:
            return self._upsert_once(
                person,
                person.remote_code,
                self.processed_persons,
                self.person_repo,
                self.person_e_repo,
                remote_code=person.remote_code,
            )

    def import_goals(self) -> Msg:
        self._reset_processed()

        # структура всех задач с проектами и подпроектами
        for task in self.import_repo.get_tasks_tree():
            self._upsert_task(task)

        # отдельно проекты ради пустых проектов
        for goal in self.import_repo.get_goals():
            self._upsert_goal(goal)

        return Msg(msg=f"Goals from {self.import_repo.source} imported successful")
