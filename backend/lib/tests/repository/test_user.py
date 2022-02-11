#  Copyright (c) 2022. Alexandr Moroz

from lib.L3_data.repositories import security_repo, user_repo
from lib.tests.utils.user import random_user


def test_get_user():
    with random_user() as user_out:
        user_out2 = user_repo.get_one(id=user_out.id)

        assert user_out == user_out2


def test_create_user():

    password = "password"
    with random_user(password) as user_out:
        user_out2 = user_repo.get_one(id=user_out.id)

        assert user_out == user_out2
        assert user_out.password != password
        assert security_repo.verify_password(password, user_out.password)


def test_update_user():
    with random_user() as user_out:
        user_out.password = new_password = "new_password"
        updated_rows = user_repo.update(user_out)
        user_out2 = user_repo.get_one(id=user_out.id)

        assert updated_rows > 0
        assert user_out == user_out2
        assert user_out.password != new_password
        assert security_repo.verify_password(new_password, user_out.password)


def test_delete_user():
    with random_user() as user_out:
        assert user_repo.delete(user_out) == 1


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
#     authenticated_user = user_repo.get_one(email=email)
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
