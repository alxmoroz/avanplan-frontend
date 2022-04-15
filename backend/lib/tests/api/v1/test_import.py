#  Copyright (c) 2022. Alexandr Moroz
import pytest
from fastapi.encoders import jsonable_encoder
from fastapi.testclient import TestClient
from pydantic import HttpUrl

from lib.L2_data.models import RemoteTracker, RemoteTrackerType
from lib.L2_data.repositories.db import RemoteTrackerRepo, RemoteTrackerTypeRepo
from lib.L2_data.schema import RemoteTrackerSchemaUpsert, RemoteTrackerTypeSchemaUpsert
from lib.L2_data.settings import settings
from lib.L3_app.api.v1.integrations.routers import goals_router, integrations_router

# TODO: 1951 нельзя привязываться к конкретному редмайну и оставлять тут креды для доступа к нему
#  апи тестируем на фронте...


@pytest.fixture(scope="session")
def tmp_remote_tracker_type_redmine(remote_tracker_type_repo: RemoteTrackerTypeRepo) -> RemoteTrackerType:
    tt = remote_tracker_type_repo.get_one(title="Redmine")
    if not tt:
        s = RemoteTrackerTypeSchemaUpsert(title="Redmine")
        tt = remote_tracker_type_repo.upsert(jsonable_encoder(s))
    yield tt


# TODO: реальные креды...
@pytest.fixture(scope="session")
def tmp_remote_tracker_redmine(remote_tracker_repo: RemoteTrackerRepo, tmp_remote_tracker_type_redmine) -> RemoteTracker:
    tr = remote_tracker_repo.get_one(url="https://redmine.moroz.team")
    if not tr:
        s = RemoteTrackerSchemaUpsert(
            description="tmp_remote_tracker",
            remote_tracker_type_id=tmp_remote_tracker_type_redmine.id,
            url=HttpUrl("https://redmine.moroz.team", scheme="https"),
            login_key="101b62ea94b4132625a3d079451ea13fed3f4b87",
        )
        tr = remote_tracker_repo.upsert(jsonable_encoder(s))
    yield tr


_api_path = f"{settings.API_PATH}{integrations_router.prefix}{goals_router.prefix}"


def test_get_import_goals(client: TestClient, auth_headers_test_user, tmp_remote_tracker_redmine: RemoteTracker):
    r_goals = client.get(
        _api_path,
        headers=auth_headers_test_user,
        params={"tracker_id": tmp_remote_tracker_redmine.id},
    )

    assert r_goals.status_code == 200, r_goals.json()
    goals_ids = [r["remote_code"] for r in r_goals.json()]
    assert len(goals_ids) > 0

    r = client.post(
        f"{_api_path}/import",
        headers=auth_headers_test_user,
        params={"tracker_id": tmp_remote_tracker_redmine.id},
        json=goals_ids,
    )

    assert r.status_code == 200, r.json()
    assert r.json()["msg"] == f"Goals from {tmp_remote_tracker_redmine.type.title} {tmp_remote_tracker_redmine.url} imported successful"

    # goals = goal_repo.get(where=not_(column("id") == tmp_goal.id))
    # for g in goals:
    #     goal_repo.delete(g.id)

    # # 400 (no id)
    # r2 = client.post(
    #     r.request.path_url,
    #     headers=auth_headers_test_user,
    # )
    #
    # assert r2.status_code == 400


# def test_import_tasks(client: TestClient, auth_headers_test_user):
#     r = _request(client, auth_headers_test_user, "tasks")
#     assert r.status_code == 200, r.json()["detail"]
#     assert r.json()["msg"] == f"Tasks with goals from Redmine {_host} imported successful"
