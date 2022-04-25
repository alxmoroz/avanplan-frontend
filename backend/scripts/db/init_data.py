#  Copyright (c) 2022. Alexandr Moroz
import os

from fastapi.encoders import jsonable_encoder

from lib.L2_data.db import session_maker_for_org
from lib.L2_data.repositories.db.auth.organization_repo import OrganizationRepo
from lib.L2_data.schema import OrganizationSchemaUpsert
from lib.L2_data.schema import RemoteTrackerTypeSchemaUpsert, UserSchemaUpsert
from lib.L2_data.repositories.db import UserRepo, RemoteTrackerTypeRepo
from lib.L2_data.settings import settings


def init_data():
    auth_db = None
    data_db = None
    try:
        auth_db = session_maker_for_org("auth")()

        # Organization
        org_repo = OrganizationRepo(auth_db)
        org_name = os.getenv("H_ORG_NAME")
        org = org_repo.get_one(name=org_name)
        if not org:
            s = OrganizationSchemaUpsert(name=org_name)
            org = org_repo.upsert(jsonable_encoder(s))
            if org:
                print(f"Organization {org.name} created")

        # Default Admin
        user_repo = UserRepo(auth_db)
        admin_user = user_repo.get_one(email=settings.DEFAULT_ADMIN_EMAIL, organization_id=org.id)
        if not admin_user:
            s = UserSchemaUpsert(
                email=settings.DEFAULT_ADMIN_EMAIL, password=settings.DEFAULT_ADMIN_PASSWORD, is_superuser=True, organization_id=org.id
            )
            admin_user = user_repo.upsert(jsonable_encoder(s))
            if admin_user:
                print(f"Admin created {admin_user}")
        data_db = session_maker_for_org(org.name)()
        # Remote Tracker type
        ttype_repo = RemoteTrackerTypeRepo(data_db)
        for code in ["Redmine", "Jira", "Trello"]:
            type_in_db = ttype_repo.get_one(title=code)
            if not type_in_db:
                ttype_repo.upsert(jsonable_encoder(RemoteTrackerTypeSchemaUpsert(title=code)))
                print(f"Remote Tracker type {code} created")
    finally:
        auth_db.close()
        data_db.close()


init_data()
