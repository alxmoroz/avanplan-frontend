#  Copyright (c) 2022. Alexandr Moroz
from datetime import datetime, timedelta
from typing import Generic

from ..entities.api.exceptions import ApiException
from ..entities.goals import Goal, GoalReport, Task
from ..repositories.abstract_db_repo import AbstractDBRepo, M
from ..repositories.abstract_entity_repo import AbstractEntityRepo, SCreate, SGet


class GoalsUC(Generic[M, SGet]):
    def __init__(
        self,
        goal_db_repo: AbstractDBRepo,
        goal_e_repo: AbstractEntityRepo,
        task_db_repo: AbstractDBRepo,
        task_e_repo: AbstractEntityRepo,
    ):
        self.goal_db_repo = goal_db_repo
        self.goal_e_repo = goal_e_repo

        self.task_db_repo = task_db_repo
        self.task_e_repo = task_e_repo

    def _calculate_goal(self, goal: Goal) -> SGet:
        # TODO: для гет-схемы цели можно получить сразу задачи эти
        tasks: list[Task] = [self.task_e_repo.entity_from_orm(db_obj) for db_obj in self.task_db_repo.get(goal_id=goal.id)]

        tasks_count = len(tasks)
        closed_tasks_count = sum(map(lambda t: t.closed, tasks))

        left_tasks_count = tasks_count - closed_tasks_count

        planned_seconds = goal.past_period.total_seconds() + 1
        fact_speed = closed_tasks_count / planned_seconds
        eta_date = None
        plan_speed = 0

        if fact_speed:
            eta_seconds = left_tasks_count / fact_speed
            eta_date = datetime.now() + timedelta(seconds=eta_seconds)

        if goal.planned_period:
            planned_seconds = goal.planned_period.total_seconds() + 1
            plan_speed = tasks_count / planned_seconds
            # print(f" rel_speed {goal.fact_speed / goal.plan_speed * 100 :.0f} %")
            # left_period = goal.planned_period - goal.past_period
            # print(f" target_speed {left_tasks_count / left_period.total_seconds() * 3600 * 24 :.2f}")

        goal.report = GoalReport(
            tasks_count=tasks_count,
            closed_tasks_count=closed_tasks_count,
            eta_date=eta_date,
            plan_speed=plan_speed,
            fact_speed=fact_speed,
        )

        return goal

    def get_goals(self) -> list[Goal]:
        goals: list[Goal] = [self.goal_e_repo.entity_from_orm(db_obj) for db_obj in self.goal_db_repo.get()]

        for goal in goals:
            self._calculate_goal(goal)

        return goals

    def upsert_goal(self, s: SCreate) -> Goal:
        return self.goal_e_repo.entity_from_orm(self.goal_db_repo.update(s))

    def delete_goal(self, goal_id: int) -> int:
        deleted_count = self.goal_db_repo.delete(goal_id)
        if deleted_count < 1:
            raise ApiException(400, f"Error deleting goal id = {goal_id}")
        return deleted_count
