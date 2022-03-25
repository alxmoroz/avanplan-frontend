#  Copyright (c) 2022. Alexandr Moroz

from ..entities.api.exceptions import ApiException
from ..repositories.abstract_db_repo import AbstractDBRepo
from ..repositories.abstract_entity_repo import AbstractEntityRepo, E, SUpd


class StatusUC:
    def __init__(
        self,
        db_repo: AbstractDBRepo,
        e_repo: AbstractEntityRepo,
    ):
        self.db_repo = db_repo
        self.e_repo = e_repo

    def get_statuses(self) -> list[E]:
        statuses: list[E] = [self.e_repo.entity_from_orm(db_obj) for db_obj in self.db_repo.get()]
        return statuses

    def upsert_status(self, s: SUpd) -> E:

        data = self.e_repo.dict_from_schema_upd(s)
        status = self.e_repo.entity_from_orm(self.db_repo.upsert(data))

        return status

    def delete_status(self, status_id: int) -> int:
        deleted_count = self.db_repo.delete(status_id)
        if deleted_count < 1:
            raise ApiException(400, f"Error deleting {E} id = {status_id}")
        return deleted_count
