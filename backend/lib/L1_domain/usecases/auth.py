#  Copyright (c) 2022. Alexandr Moroz

from lib.L1_domain.entities import auth
from lib.L1_domain.repositories import AbstractDBRepo, BaseSecurityRepo


class AuthException(Exception):
    def __init__(self, code: int, detail: str | None):
        self.code = code
        self.detail = detail


class AuthUseCase:
    def __init__(self, user_repo: AbstractDBRepo, security_repo: BaseSecurityRepo):
        self.user_repo = user_repo
        self.sec_repo = security_repo

    def authenticate(self, username: str, password: str) -> auth.Token:

        user = self.user_repo.get_one(email=username)

        if not user or not self.sec_repo.verify_password(password, user.password):
            raise AuthException(code=403, detail="Incorrect username or password")
        elif not user.is_active:
            raise AuthException(code=403, detail="Inactive user")

        return self.sec_repo.create_token(str(user.id))

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
