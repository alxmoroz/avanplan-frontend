#  Copyright (c) 2022. Alexandr Moroz

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
            # for t in tasks:
            #     print(t.title)
            #     print(t.goal_id)

            print()
            print(goal.title)
            print(f" planned_period {goal.planned_period}")
            print(f" past_period {goal.past_period}")
            print(goal.plan_speed or "---")
            print(goal.fact_speed or "---")

            tasks_count = len(tasks)
            if goal.planned_period:
                goal.plan_speed = tasks_count / goal.planned_period.seconds * 3600

            closed_tasks_count = sum(map(lambda t: t.closed, tasks))

            if goal.past_period:
                goal.fact_speed = closed_tasks_count / (goal.past_period.seconds + 1) * 3600

        return goals

    # def get_goal(self, goal_id: int) -> Goal:
    #     goal: Goal = self.goal_repo.get_one(id=goal_id)
    #     if not goal:
    #         raise ApiException(404, f"There is no such goal with id {goal_id}")
    #     return goal
