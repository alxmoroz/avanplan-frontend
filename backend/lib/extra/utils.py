#  Copyright (c) 2022. Alexandr Moroz

# def generate_password_reset_token(email: str) -> str:
#     delta = timedelta(hours=settings.EMAIL_RESET_TOKEN_EXPIRE_HOURS)
#     now = datetime.utcnow()
#     expires = now + delta
#     exp = expires.timestamp()
#     encoded_jwt = jwt.encode(
#         {"exp": exp, "nbf": now, "sub": email},
#         settings.SECRET_KEY
#     )
#     return encoded_jwt


# def verify_password_reset_token(token: str) -> str | None:
#     try:
#         decoded_token = jwt.decode(token, settings.SECRET_KEY, algorithms=[jwt.ALGORITHMS.HS256])
#         return decoded_token["email"]
#     except jwt.JWTError:
#         return None
