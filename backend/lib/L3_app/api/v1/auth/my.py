#  Copyright (c) 2022. Alexandr Moroz

from fastapi import APIRouter, Body, Depends
from sqlalchemy.orm import Session

from lib.L1_domain.entities import User, Workspace, WSUserRole
from lib.L1_domain.usecases.auth_uc import AuthUC
from lib.L1_domain.usecases.base_db_uc import BaseDBUC
from lib.L2_data.mappers import WSUserRoleMapper
from lib.L2_data.repositories.db import WSUserRoleRepo
from lib.L2_data.schema import UserSchemaGet, WorkspaceSchemaGet

from .auth import auth_db, auth_uc, auth_user

router = APIRouter(prefix="/my")


def _ws_user_role_uc(
    db: Session = Depends(auth_db),
) -> BaseDBUC:
    return BaseDBUC(
        repo=WSUserRoleRepo(db),
        mapper=WSUserRoleMapper(),
    )


@router.get("/workspaces", response_model=list[WorkspaceSchemaGet])
def get_my_workspaces(
    uc: BaseDBUC = Depends(_ws_user_role_uc),
    user: User = Depends(auth_user),
) -> list[Workspace]:
    roles: list[WSUserRole] = uc.get_all(user_id=user.id)

    return [ws_user_role.workspace for ws_user_role in roles]


@router.get("/account", response_model=UserSchemaGet)
def get_my_account(
    user: User = Depends(auth_user),
) -> User:
    return user


@router.put("/account", response_model=UserSchemaGet)
def update_my_account(
    password: str = Body(None),
    full_name: str = Body(None),
    uc: AuthUC = Depends(auth_uc),
) -> User:
    return uc.update_my_account(full_name=full_name, password=password)


# TODO: другие пользователи могут видеть некоторую инфу по пользователям. Возможно, в другом методе или вьюхе это должно быть.
# @router.get("/{user_id}", response_model=schemas.User)
# def get_user_by_id(
#     user_id: int,
#     _db: Session = Depends(deps.get_db),
#     current_user: UserModel = Depends(deps.get_current_active_user),
# ) -> UserModel:
#     """
#     Get a specific user by id.
#     """
#     user = user.get_one(p_id=user_id)
#     if current_user == user:
#         return user
#     if not user.is_superuser:
#         raise HTTPException(
#             status_code=403, detail="The user doesn't have enough privileges"
#         )
#     return user

# @router.post("/reset-password/", response_model=schemas.Msg)
# def reset_password(
#         token: str = Body(...),
#         new_password: str = Body(...),
#         _db: Session = Depends(deps.get_db),
# ) -> any:
#     """
#     Reset password
#     """
#     email = verify_password_reset_token(token)
#     if not email:
#         raise HTTPException(status_code=400, detail="Invalid token")
#     user = ws_repo.get_one(email=email)
#     if not user:
#         raise HTTPException(
#             status_code=404,
#             detail="The user with this username does not exist in the system.",
#         )
#     elif not user.is_active:
#         raise HTTPException(status_code=400, detail="Inactive user")
#     hashed_password = get_password_hash(new_password)
#     user.hashed_password = hashed_password
#     _db.add(user)
#     _db.commit()
#     return {"msg": "Password updated successfully"}
