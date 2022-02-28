#  Copyright (c) 2022. Alexandr Moroz

from sqlalchemy.orm import Session

from lib.L1_domain.entities.base_entity import DBPersistent
from lib.L1_domain.entities.goals import BaseSmartPersistent, Task
from lib.L2_data.models import Task as TaskModel

from ..db_repo import DBRepo
from .goal_repo import GoalRepo
from .milestone_repo import MilestoneRepo
from .person_repo import PersonRepo
from .task_priority_repo import TaskPriorityRepo
from .task_status_repo import TaskStatusRepo


class TaskUpsertSchema(BaseSmartPersistent):
    goal_id: int | None
    parent_id: int | None
    milestone_id: int | None
    status_id: int | None
    priority_id: int | None
    assignee_id: int | None
    author_id: int | None


def _get_rel_id(repo: DBRepo, rel: DBPersistent) -> int | None:
    return (rel.id or repo.upsert(rel).id) if rel else None


class TaskRepo(DBRepo):
    def __init__(self, db: Session):
        self.goal_repo = GoalRepo(db)
        self.milestone_repo = MilestoneRepo(db)
        self.task_status_repo = TaskStatusRepo(db)
        self.task_priority_repo = TaskPriorityRepo(db)
        self.person_repo = PersonRepo(db)
        super().__init__(TaskModel, Task, db)

    def _prepare_upsert_data(self, task: Task) -> any:
        upsert_data = TaskUpsertSchema(
            goal_id=_get_rel_id(self.goal_repo, task.goal),
            parent_id=_get_rel_id(self, task.parent),
            milestone_id=_get_rel_id(self.milestone_repo, task.milestone),
            status_id=_get_rel_id(self.task_status_repo, task.status),
            priority_id=_get_rel_id(self.task_priority_repo, task.priority),
            assignee_id=_get_rel_id(self.person_repo, task.assignee),
            author_id=_get_rel_id(self.person_repo, task.author),
            **task.dict(),
        )
        return super()._prepare_upsert_data(upsert_data)
