#  Copyright (c) 2022. Alexandr Moroz


# _persons_api_path = f"{settings.API_PATH}{router.prefix}/persons"


# def test_get_persons(client: TestClient, auth_headers_test_user, tmp_person):
#     r = client.get(_persons_api_path, headers=auth_headers_test_user)
#     assert r.status_code == 200
#     json_persons = r.json()
#     persons_out = [Person(**json_person) for json_person in json_persons]
#     assert tmp_person in persons_out
#
#
# def test_resource_401(client: TestClient):
#
#     # not auth
#     r1 = client.get(_persons_api_path, headers={})
#     assert r1.json()["detail"] == "Not authenticated"
#     assert r1.status_code == 401
