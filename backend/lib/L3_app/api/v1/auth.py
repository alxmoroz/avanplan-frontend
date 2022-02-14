#  Copyright (c) 2022. Alexandr Moroz


from fastapi import APIRouter, Depends, HTTPException
from fastapi.security import OAuth2PasswordRequestForm

from lib.L1_domain.entities.auth import Token
from lib.L1_domain.entities.users import User
from lib.L1_domain.usecases.auth import AuthException, AuthUseCase
from lib.L2_data.models.users import User as UserModel
from lib.L2_data.repositories import DBRepo, SecurityRepo

router = APIRouter(prefix="/auth")

security_repo = SecurityRepo()
user_repo = DBRepo(UserModel, User)


@router.post("/token", response_model=Token, operation_id="get_auth_token")
def token(form_data: OAuth2PasswordRequestForm = Depends()) -> Token:
    """
    OAuth2 token login, access token for future requests
    """
    try:
        t = AuthUseCase(user_repo, security_repo).get_token(
            username=form_data.username,
            password=form_data.password,
        )
    except AuthException as a:
        raise HTTPException(status_code=a.code, detail=a.detail)

    return t


# @router.post("/reset-password/", response_model=schemas.Msg)
# def reset_password(
#         token: str = Body(...),
#         new_password: str = Body(...),
#         db: Session = Depends(deps.get_db),
# ) -> any:
#     """
#     Reset password
#     """
#     email = verify_password_reset_token(token)
#     if not email:
#         raise HTTPException(status_code=400, detail="Invalid token")
#     user = user_repo.get_one(email=email)
#     if not user:
#         raise HTTPException(
#             status_code=404,
#             detail="The user with this username does not exist in the system.",
#         )
#     elif not user.is_active:
#         raise HTTPException(status_code=400, detail="Inactive user")
#     hashed_password = get_password_hash(new_password)
#     user.hashed_password = hashed_password
#     db.add(user)
#     db.commit()
#     return {"msg": "Password updated successfully"}
