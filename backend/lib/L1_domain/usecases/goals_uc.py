#  Copyright (c) 2022. Alexandr Moroz
from datetime import datetime, timedelta

from ..entities.api.exceptions import ApiException
from ..entities.goals import Goal, GoalReport, Task
from ..repositories.abstract_db_repo import AbstractDBRepo, S


class GoalsUC:
    def __init__(
        self,
        goal_repo: AbstractDBRepo,
        task_repo: AbstractDBRepo,
    ):
        self.goal_repo = goal_repo
        self.task_repo = task_repo

    def _calculate_goal(self, goal: Goal):
        # TODO: для гет-схемы цели можно получить сразу задачи эти
        tasks: list[Task] = self.task_repo.get(goal_id=goal.id)

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

        print(goal.report)

        return goal

    def get_goals(self) -> list[Goal]:
        goals: list[Goal] = self.goal_repo.get()
        for goal in goals:
            self._calculate_goal(goal)

        return goals

    def upsert_goal(self, s: S) -> Goal:
        return self.goal_repo.update(s)

    def delete_goal(self, goal_id: int) -> int:
        deleted_count = self.goal_repo.delete(goal_id)
        if deleted_count < 1:
            raise ApiException(400, f"Error deleting goal id = {goal_id}")
        return deleted_count
