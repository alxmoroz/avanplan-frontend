#  Copyright (c) 2022. Alexandr Moroz

from fastapi.testclient import TestClient

from lib.L1_domain.entities import Goal
from lib.L2_data.repositories import GoalRepo
from lib.L2_data.schema import GoalSchema
from lib.L2_data.settings import settings
from lib.L3_app.api.v1.goals import router

_goals_api_path = f"{settings.API_PATH}{router.prefix}"


def _goal_from_json(repo: GoalRepo, json: dict) -> Goal:
    return repo.entity_from_schema(GoalSchema(**json))


def test_get_goals(client: TestClient, auth_headers_test_user, tmp_goal, goal_repo: GoalRepo):

    r = client.get(_goals_api_path, headers=auth_headers_test_user)
    assert r.status_code == 200, r
    json_goals = r.json()
    goals_out = [_goal_from_json(goal_repo, json_goal) for json_goal in json_goals]
    tmp_goal.tasks_count = tmp_goal.closed_tasks_count = tmp_goal.fact_speed = 0

    assert tmp_goal in goals_out


def test_resource_401(client: TestClient):

    # not auth
    r1 = client.get(_goals_api_path, headers={})
    assert r1.json()["detail"] == "Not authenticated"
    assert r1.status_code == 401
