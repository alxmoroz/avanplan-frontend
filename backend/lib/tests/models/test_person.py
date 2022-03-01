#  Copyright (c) 2022. Alexandr Moroz

from datetime import datetime

from sqlalchemy import column

from lib.L1_domain.entities.goals import Person


def test_get_one(person_repo, tmp_person):
    obj_out = person_repo.get_one(id=tmp_person.id)
    assert tmp_person == obj_out


def test_get_create(person_repo, tmp_person):

    obj2 = person_repo.create(Person(firstname="2"))

    objects = person_repo.get(
        limit=2,
        where=column("id").in_([tmp_person.id, obj2.id]),
    )
    assert tmp_person in objects
    assert obj2 in objects
    assert len(objects) == 2

    assert person_repo.delete(obj2) == 1


def test_update(person_repo, tmp_person):

    firstname = tmp_person.firstname = "firstname"
    lastname = tmp_person.lastname = "lastname"
    remote_code = tmp_person.remote_code = "remote_code"
    updated_on = tmp_person.updated_on = datetime.now()
    assert person_repo.update(tmp_person) == 1

    obj_out = person_repo.get_one(id=tmp_person.id)
    assert tmp_person == obj_out
    assert obj_out.firstname == firstname
    assert obj_out.lastname == lastname
    assert obj_out.remote_code == remote_code
    assert obj_out.updated_on == updated_on


def test_upsert_delete(person_repo):
    # create
    person = Person(firstname="person")
    obj_out = person_repo.upsert(person)
    # TODO: Если убрать айдишники под капот (в Л2, в схемы в репах), то тут их не будет
    person.id = obj_out.id
    assert obj_out == person

    # update
    person.firstname = "firstname"
    person.lastname = "lastname"
    assert person_repo.upsert(person) == person

    # delete
    assert person_repo.delete(person) == 1
