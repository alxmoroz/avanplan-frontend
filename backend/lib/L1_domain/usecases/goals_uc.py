#  Copyright (c) 2022. Alexandr Moroz
from datetime import datetime, timedelta

from ..entities.api.exceptions import ApiException
from ..entities.goals import Goal, Task, SmartPersistent
from ..repositories import AbstractDBRepo


class GoalsUC:
    def __init__(
        self,
        goal_repo: AbstractDBRepo,
        task_repo: AbstractDBRepo,
    ):
        self.goal_repo = goal_repo
        self.task_repo = task_repo

    def _calculate_goal(self, goal: Goal):
        tasks: list[Task] = self.task_repo.get(goal_id=goal.id)

        print()
        print(goal.title)

        goal.tasks_count = len(tasks)
        goal.closed_tasks_count = sum(map(lambda t: t.closed, tasks))
        left_tasks_count = goal.tasks_count - goal.closed_tasks_count

        planned_seconds = goal.past_period.total_seconds() + 1
        goal.fact_speed = goal.closed_tasks_count / planned_seconds
        if goal.fact_speed:
            eta_seconds = left_tasks_count / goal.fact_speed
            goal.eta_date = datetime.now() + timedelta(seconds=eta_seconds)

        if goal.planned_period:
            planned_seconds = goal.planned_period.total_seconds() + 1
            goal.plan_speed = goal.tasks_count / planned_seconds
            # print(f" rel_speed {goal.fact_speed / goal.plan_speed * 100 :.0f} %")
            # left_period = goal.planned_period - goal.past_period
            # print(f" target_speed {left_tasks_count / left_period.total_seconds() * 3600 * 24 :.2f}")
        return goal

    def get_goals(self) -> list[Goal]:
        goals: list[Goal] = self.goal_repo.get()
        for goal in goals:
            self._calculate_goal(goal)

        return goals

    def upsert_goal(self, goal: SmartPersistent) -> Goal:
        goal = self.goal_repo.upsert(goal)
        return goal

    def delete_goal(self, goal_id: int) -> int:
        deleted_count = self.goal_repo.delete(goal_id)
        if deleted_count < 1:
            raise ApiException(400, f"Error deleting goal id = {goal_id}")
        return deleted_count
