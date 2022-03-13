#  Copyright (c) 2022. Alexandr Moroz

from datetime import datetime

from fastapi.encoders import jsonable_encoder
from sqlalchemy import column

from lib.L2_data.repositories.db import TaskRepo
from lib.L2_data.schema import TaskSchemaUpsert


def test_get_one(task_repo: TaskRepo, tmp_task):
    obj_out = task_repo.get_one(id=tmp_task.id)
    assert tmp_task == obj_out


def test_get_create(task_repo: TaskRepo, tmp_task, tmp_goal):
    s = TaskSchemaUpsert(title="test_get_create", goal_id=tmp_goal.id)
    obj2 = task_repo.upsert(jsonable_encoder(s))

    objects = task_repo.get(
        limit=2,
        where=column("id").in_([tmp_task.id, obj2.id]),
    )
    assert tmp_task in objects
    assert obj2 in objects
    assert len(objects) == 2

    assert task_repo.delete(obj2.id) == 1


# TODO: ещё нужно добавить проверку изменения для всех связанных объектов (айдишников)
def test_update(task_repo: TaskRepo, tmp_task, tmp_goal):

    s = TaskSchemaUpsert(
        id=tmp_task.id,
        goal_id=tmp_goal.id,
        title="test_update",
        description="description",
        due_date=datetime.now(),
    )
    obj_out = task_repo.upsert(jsonable_encoder(s))
    test_obj_out = task_repo.get_one(id=tmp_task.id)
    assert obj_out == test_obj_out
    assert obj_out.title == s.title
    assert obj_out.description == s.description
    assert obj_out.due_date == s.due_date


def test_upsert_delete(task_repo: TaskRepo, tmp_goal):
    # upsert
    s = TaskSchemaUpsert(title="test_upsert_delete", goal_id=tmp_goal.id)
    obj_out = task_repo.upsert(jsonable_encoder(s))
    test_obj_out = task_repo.get_one(id=obj_out.id)

    assert obj_out == test_obj_out
    assert s.title == obj_out.title

    # delete
    assert task_repo.delete(obj_out.id) == 1
