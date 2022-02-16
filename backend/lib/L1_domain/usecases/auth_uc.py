#  Copyright (c) 2022. Alexandr Moroz
from ..entities.api.exceptions import ApiException
from ..entities.auth import Token
from ..entities.users import User
from ..repositories import AbstractDBRepo, AbstractSecurityRepo


class AuthUC:
    def __init__(self, user_repo: AbstractDBRepo, security_repo: AbstractSecurityRepo):
        self.user_repo = user_repo
        self.sec_repo = security_repo

    def create_token_for_creds(self, username: str, password: str) -> Token:

        user: User = self.user_repo.get_one(email=username)

        if not user or not self.sec_repo.verify_password(password, user.password):
            raise ApiException(403, "Incorrect username or password")
        elif not user.is_active:
            raise ApiException(403, "Inactive user")

        return self.sec_repo.create_token(user.email)

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
