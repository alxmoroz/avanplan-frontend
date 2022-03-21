#  Copyright (c) 2022. Alexandr Moroz

from typing import Generic

from ..entities import Task
from ..entities.api.exceptions import ApiException
from ..repositories.abstract_db_repo import AbstractDBRepo, M
from ..repositories.abstract_entity_repo import AbstractEntityRepo, SGet, SUpd


class TasksUC(Generic[M, SGet]):
    def __init__(
        self,
        task_db_repo: AbstractDBRepo,
        task_e_repo: AbstractEntityRepo,
    ):
        self.task_db_repo = task_db_repo
        self.task_e_repo = task_e_repo

    def get_tasks(self) -> list[Task]:
        tasks: list[Task] = [self.task_e_repo.entity_from_orm(db_obj) for db_obj in self.task_db_repo.get()]
        return tasks

    def upsert_task(self, s: SUpd) -> Task:

        data = self.task_e_repo.dict_from_schema_upd(s)
        task = self.task_e_repo.entity_from_orm(self.task_db_repo.upsert(data))

        return task

    def delete_task(self, goal_id: int) -> int:
        deleted_count = self.task_db_repo.delete(goal_id)
        if deleted_count != 1:
            raise ApiException(400, f"Error deleting task id = {goal_id}")
        return deleted_count
