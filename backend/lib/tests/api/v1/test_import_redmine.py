#  Copyright (c) 2022. Alexandr Moroz

from fastapi.testclient import TestClient


# TODO: можно ли привязываться к конкретному редмайну и оставлять тут креды для доступа к нему?
def test_import_tasks(client: TestClient, auth_headers_test_admin):
    # assert user_out in users_out
    pass
