// Copyright (c) 2022. Alexandr Moroz

import 'package:dio/dio.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:openapi/openapi.dart';

import '../../L1_domain/repositories/abs_auth_repo.dart';
import '../../L3_app/extra/api.dart';
import '../../L3_app/extra/platform.dart';

class AuthRepo extends AbstractAuthRepo {
  AuthApi get api => openAPI.getAuthApi();

  String? _parseTokenResponse(Response<Token> tokenResponse) {
    if (tokenResponse.statusCode == 200) {
      final token = tokenResponse.data;
      if (token != null) {
        return token.accessToken;
      }
    }
    return null;
  }

  @override
  Future<String> getApiAuthToken(String username, String password) async {
    final response = await api.authToken(
      username: username,
      password: password,
    );
    return _parseTokenResponse(response) ?? '';
  }

  // TODO: тут можно throw ошибок от получения токена от гугла сделать отдельно

  @override
  Future<String> getApiAuthTokenGoogleOauth() async {
    final googleAuth = GoogleSignIn(scopes: ['email', 'profile']);
    GoogleSignInAccount? account;
    if (!await googleAuth.isSignedIn()) {
      account = await googleAuth.signIn();
    } else {
      account = await googleAuth.signInSilently();
    }
    final auth = await account?.authentication;
    if (auth != null) {
      final token = auth.idToken;
      if (token != null) {
        final Response<Token> response = await api.authTokenGoogleOauth(
          bodyAuthTokenGoogleOauth: (BodyAuthTokenGoogleOauthBuilder()
                ..googleToken = token
                ..platform = platformCode)
              .build(),
        );
        return _parseTokenResponse(response) ?? '';
      }
    }
    return '';
  }

  @override
  Future googleLogout() async {
    await GoogleSignIn().signOut();
  }

  @override
  void setApiCredentials(String token) {
    openAPI.setOAuthToken('OAuth2PasswordBearer', token);
  }
}
