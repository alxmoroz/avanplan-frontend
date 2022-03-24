#  Copyright (c) 2022. Alexandr Moroz

from typing import Generic

from ..entities import GoalStatus
from ..entities.api.exceptions import ApiException
from ..repositories.abstract_db_repo import AbstractDBRepo, M
from ..repositories.abstract_entity_repo import AbstractEntityRepo, SGet, SUpd


class GoalStatusesUC(Generic[M, SGet]):
    def __init__(
        self,
        g_status_db_repo: AbstractDBRepo,
        g_status_e_repo: AbstractEntityRepo,
    ):
        self.g_status_db_repo = g_status_db_repo
        self.g_status_e_repo = g_status_e_repo

    def get_goal_statuses(self) -> list[GoalStatus]:
        statuses: list[GoalStatus] = [self.g_status_e_repo.entity_from_orm(db_obj) for db_obj in self.g_status_db_repo.get()]
        return statuses

    def upsert_goal_status(self, s: SUpd) -> GoalStatus:

        data = self.g_status_e_repo.dict_from_schema_upd(s)
        g_status = self.g_status_e_repo.entity_from_orm(self.g_status_db_repo.upsert(data))

        return g_status

    def delete_goal_status(self, g_status_id: int) -> int:
        deleted_count = self.g_status_db_repo.delete(g_status_id)
        if deleted_count < 1:
            raise ApiException(400, f"Error deleting GoalStatus id = {g_status_id}")
        return deleted_count
