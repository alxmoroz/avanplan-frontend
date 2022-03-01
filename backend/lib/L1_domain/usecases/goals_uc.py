#  Copyright (c) 2022. Alexandr Moroz
from datetime import datetime, timedelta

from ..entities.goals import Goal, Task
from ..repositories import AbstractDBRepo


class GoalsUC:
    def __init__(
        self,
        goal_repo: AbstractDBRepo,
        task_repo: AbstractDBRepo,
    ):
        self.goal_repo = goal_repo
        self.task_repo = task_repo

    def get_goals(self) -> list[Goal]:
        goals: list[Goal] = self.goal_repo.get()
        for goal in goals:
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
                print(f" rel_speed {goal.fact_speed / goal.plan_speed * 100 :.0f} %")
                left_period = goal.planned_period - goal.past_period
                print(f" target_speed {left_tasks_count / left_period.total_seconds() * 3600 * 24 :.2f}")

        return goals
