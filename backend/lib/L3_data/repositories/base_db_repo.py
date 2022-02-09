#  Copyright (c) 2022. Alexandr Moroz

from typing import Generic, Type, TypeVar, Union

from fastapi.encoders import jsonable_encoder
from sqlalchemy.orm import Session

from lib.L1_domain.entities.base_entity import BaseEntity

from ..models.base_model import BaseModel

GetModelType = TypeVar("GetModelType", bound=BaseModel)
CreateEntityType = TypeVar("CreateEntityType", bound=BaseEntity)
UpdateEntityType = TypeVar("UpdateEntityType", bound=BaseEntity)


# TODO: нужен соотв. по интерфейсу репозиторий в Л1
class BaseDBRepo(Generic[GetModelType, CreateEntityType, UpdateEntityType]):
    def __init__(self, model: Type[GetModelType]):
        """
        CRUD object with default methods to Create, Read, Update, Delete (CRUD).

        **Parameters**

        * `model`: A SQLAlchemy model class
        * `schema`: A Pydantic model (schema) class
        """
        self.model = model

    def get(self, db: Session, p_id: any) -> GetModelType | None:
        return db.query(self.model).filter(self.model.id == p_id).first()

    def get_multi(
        self, db: Session, *, skip: int = 0, limit: int | None
    ) -> list[GetModelType]:
        clause = db.query(self.model).offset(skip)
        if limit is not None:
            clause = clause.limit(limit)
        return clause.all()

    def create(self, db: Session, *, obj_in: CreateEntityType) -> GetModelType:
        obj_in_data = jsonable_encoder(obj_in)
        db_obj = self.model(**obj_in_data)  # type: ignore
        db.add(db_obj)
        db.commit()
        db.refresh(db_obj)
        return db_obj

    def update(
        self,
        db: Session,
        *,
        db_obj: GetModelType,
        obj_in: Union[UpdateEntityType, dict[str, any]]
    ) -> GetModelType:
        obj_data = jsonable_encoder(db_obj)
        if isinstance(obj_in, dict):
            update_data = obj_in
        else:
            update_data = obj_in.dict(exclude_unset=True)
        for field in obj_data:
            if field in update_data:
                setattr(db_obj, field, update_data[field])
        db.add(db_obj)
        db.commit()
        db.refresh(db_obj)
        return db_obj

    def delete(self, db: Session, *, p_id: int) -> GetModelType:
        db_obj = db.query(self.model).get(p_id)
        db.delete(db_obj)
        db.commit()
        return db_obj
