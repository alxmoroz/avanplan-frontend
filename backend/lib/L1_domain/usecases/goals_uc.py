#  Copyright (c) 2022. Alexandr Moroz
from ..entities.api.exceptions import ApiException
from ..entities.goals import Goal
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
        return self.goal_repo.get()

    def get_goal(self, goal_id: int) -> Goal:
        goal: Goal = self.goal_repo.get_one(id=goal_id)
        if not goal:
            raise ApiException(404, f"There is no such goal with id {goal_id}")
        return goal
