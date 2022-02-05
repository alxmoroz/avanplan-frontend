from datetime import timedelta

from fastapi import APIRouter, Depends, HTTPException
from fastapi.security import OAuth2PasswordRequestForm
from sqlalchemy.orm import Session

from lib.L3_data import crud, schemas
from .. import deps, security

# from lib.extra.utils import verify_password_reset_token

router = APIRouter()


@router.post("/token", response_model=schemas.Token)
def token(
        db: Session = Depends(deps.get_db), form_data: OAuth2PasswordRequestForm = Depends()
) -> any:
    """
    OAuth2 compatible token login, get an access token for future requests
    """
    user = crud.user.authenticate(
        db, email=form_data.username, password=form_data.password
    )
    if not user:
        raise HTTPException(status_code=400, detail="Incorrect email or password")
    elif not user.is_active:
        raise HTTPException(status_code=403, detail="Inactive user")
    token_expires = timedelta(minutes=security.AUTH_TOKEN_EXPIRATION_MINUTES)
    return {
        "access_token": security.create_token(user.id, expires_delta=token_expires),
        "token_type": "bearer",
    }

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
#     user = crud.user.get_by_email(db, email=email)
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
