#  Copyright (c) 2022. Alexandr Moroz

from datetime import datetime, timedelta

from pytz import utc

from lib.L1_domain.entities import Goal, GoalReport
from lib.L2_data.models import Goal as GoalModel
from lib.L2_data.schema import GoalSchemaGet, GoalSchemaUpsert

from ..entity_repo import EntityRepo
from .goal_report import GoalReportRepo
from .goal_status_repo import GoalStatusRepo
from .task_repo import TaskRepo


class GoalRepo(EntityRepo[GoalSchemaGet, GoalSchemaUpsert, Goal, GoalModel]):
    def __init__(self):
        super().__init__(
            schema_get_cls=GoalSchemaGet,
            schema_upd_cls=GoalSchemaUpsert,
            entity_cls=Goal,
        )

    def entity_from_schema_get(self, s: GoalSchemaGet) -> Goal | None:
        if s:
            g: Goal = super().entity_from_schema_get(s)
            g.status = GoalStatusRepo().entity_from_schema_get(s.status)
            g.report = GoalReportRepo().entity_from_schema_get(s.report)
            g.tasks = [TaskRepo().entity_from_schema_get(t) for t in s.tasks]
            return g

    # TODO: размазанная между фронтом и бэком логика
    # TODO: вернуть в юзкейсы или вынести на фронт
    @staticmethod
    def _calculate_goal(goal: Goal):

        tasks = goal.tasks

        tasks_count = len(tasks)
        closed_tasks_count = sum(map(lambda t: t.closed, tasks))

        left_tasks_count = tasks_count - closed_tasks_count

        planned_seconds = goal.past_period.total_seconds() + 1
        fact_speed = closed_tasks_count / planned_seconds
        eta_date = None
        plan_speed = 0

        if fact_speed:
            eta_seconds = left_tasks_count / fact_speed
            eta_date = datetime.now(tz=utc) + timedelta(seconds=eta_seconds)

        if goal.planned_period:
            planned_seconds = goal.planned_period.total_seconds() + 1
            plan_speed = tasks_count / planned_seconds
            # print(f" rel_speed {goal.fact_speed / goal.plan_speed * 100 :.0f} %")
            # left_period = goal.planned_period - goal.past_period
            # print(f" target_speed {left_tasks_count / left_period.total_seconds() * 3600 * 24 :.2f}")

        goal.report = GoalReport(
            eta_date=eta_date,
            plan_speed=plan_speed,
            fact_speed=fact_speed,
        )

    def entity_from_orm(self, db_obj: GoalModel) -> Goal:
        goal = super().entity_from_orm(db_obj)
        self._calculate_goal(goal)
        return goal
