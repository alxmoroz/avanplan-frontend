#  Copyright (c) 2022. Alexandr Moroz

from fastapi.encoders import jsonable_encoder

from lib.L1_domain.entities.users.user import User
from lib.L3_data.repositories import security_repo, user_repo
from lib.tests.utils.user import random_email, random_lower_string


def test_get_user():
    password = random_lower_string()
    username = random_email()
    user_in = User(email=username, password=password, is_superuser=True)
    user = user_repo.create(user_in)
    user_2 = user_repo.get(dict(id=user.id))[0]
    assert user_2
    assert user.email == user_2.email
    assert jsonable_encoder(user) == jsonable_encoder(user_2)
    user_repo.delete(user)


def test_create_user():
    email = random_email()
    password = random_lower_string()
    user_in = User(email=email, password=password)
    user_out = user_repo.create(user_in)
    assert user_out.email == email
    assert user_out.password != password
    assert security_repo.verify_password(password, user_out.password)
    user_repo.delete(user_out)


def test_update_user():
    password = random_lower_string()
    email = random_email()
    user_out = user_repo.create(User(email=email, password=password))

    new_password = random_lower_string()
    user_out.password = new_password
    updated_rows = user_repo.update(user_out)

    user_out2 = user_repo.get(dict(id=user_out.id))[0]

    assert updated_rows > 0
    assert user_out.password == user_out2.password
    assert security_repo.verify_password(new_password, user_out.password)
    assert security_repo.verify_password(new_password, user_out2.password)

    user_repo.delete(user_out)


# TODO: это тесты юзкейсов
# def test_authenticate_user():
#     email = random_email()
#     password = random_lower_string()
#
#     user = user_repo.create(obj_in=CreateUser(email=email, password=password))
#
#     token = AuthUseCase(user_repo, security_repo).authenticate(
#         username=email,
#         password=password,
#     )
#     authenticated_user = user_repo.get_by_email(email=email)
#
#     assert token and authenticated_user
#     assert user.email == authenticated_user.email
#     user_repo.delete(p_id=user.id)


# def test_not_authenticate_user():
#     email = random_email()
#     password = random_lower_string()
#     AuthUseCase(user_repo, security_repo).authenticate(
#         username=email,
#         password=password,
#     )
#     assert Exception
#     # assert token is None

# def test_check_user_active():
#     email = random_email()
#     password = random_lower_string()
#     user_in = User(email=email, password=password)
#     user = user_repo.create(obj_in=user_in)
#     assert user.is_active
#     user_repo.delete(p_id=user.id)
#
#
# def test_check_user_inactive() -> None:
#     email = random_email()
#     password = random_lower_string()
#     user_in = CreateUser(email=email, password=password, is_active=False)
#     user = user_repo.create(obj_in=user_in)
#     assert user.is_active is False
#     user_repo.delete(p_id=user.id)
#
#
# def test_check_if_user_is_superuser() -> None:
#     email = random_email()
#     password = random_lower_string()
#     user_in = CreateUser(email=email, password=password, is_superuser=True)
#     user = user_repo.create(obj_in=user_in)
#     assert user.is_superuser is True
#     user_repo.delete(p_id=user.id)
#
#
# def test_check_if_user_is_superuser_normal_user() -> None:
#     username = random_email()
#     password = random_lower_string()
#     user_in = CreateUser(email=username, password=password)
#     user = user_repo.create(obj_in=user_in)
#     assert user.is_superuser is False
#     user_repo.delete(p_id=user.id)
