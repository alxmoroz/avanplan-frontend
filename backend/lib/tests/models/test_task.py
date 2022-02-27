#  Copyright (c) 2022. Alexandr Moroz

from datetime import datetime

from sqlalchemy import column

from lib.L1_domain.entities.goals import Task


def test_get_one(task_repo, tmp_task):
    obj_out = task_repo.get_one(id=tmp_task.id)
    assert tmp_task == obj_out


def test_get_create(task_repo, tmp_task, tmp_goal):

    obj2 = task_repo.create(Task(title="test_get", goal=tmp_goal))

    objects = task_repo.get(
        limit=2,
        where=column("id").in_([tmp_task.id, obj2.id]),
    )
    assert tmp_task in objects
    assert obj2 in objects
    assert len(objects) == 2


# TODO: ещё нужно добавить проверку изменения для всех связанных объектов (айдишников)
def test_update(task_repo, tmp_task):
    title = tmp_task.title = "title"
    description = tmp_task.description = "description"
    remote_code = tmp_task.remote_code = "remote_code"
    imported_on = tmp_task.imported_on = datetime.now()
    start_date = tmp_task.start_date = datetime.now()
    due_date = tmp_task.due_date = datetime.now()
    assert task_repo.update(tmp_task) == 1

    obj_out = task_repo.get_one(id=tmp_task.id)
    assert tmp_task == obj_out
    assert obj_out.title == title
    assert obj_out.description == description
    assert obj_out.remote_code == remote_code
    assert obj_out.imported_on == imported_on
    assert obj_out.start_date == start_date
    assert obj_out.due_date == due_date


def test_upsert_delete(task_repo, tmp_goal):
    # create
    task = Task(title="test_upsert_delete", goal=tmp_goal)
    obj_out = task_repo.upsert(task)
    # TODO: Если убрать айдишники под капот (в Л2, в схемы в репах), то тут их не будет
    task.id = obj_out.id
    assert task_repo.upsert(task) == task

    # update
    task.description = "description"
    assert task_repo.upsert(task) == task

    # delete
    assert task_repo.delete(task) == 1
