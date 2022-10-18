// Copyright (c) 2022. Alexandr Moroz

import 'package:dio/dio.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:openapi/openapi.dart';

import '../../L1_domain/repositories/abs_auth_repo.dart';
import '../../L1_domain/system/errors.dart';
import '../../L3_app/extra/platform.dart';
import '../../L3_app/extra/services.dart';

class AuthRepo extends AbstractAuthRepo {
  AuthApi get api => openAPI.getAuthApi();

  String? _parseTokenResponse(Response<Token> tokenResponse) {
    if (tokenResponse.statusCode == 200) {
      final token = tokenResponse.data;
      if (token != null) {
        return token.accessToken;
      }
    } else {
      throw MTException(code: '${tokenResponse.statusCode}', detail: tokenResponse.statusMessage);
    }
    return null;
  }

  @override
  Future<String> getApiAuthToken(String username, String password) async {
    try {
      final response = await api.authToken(
        username: username,
        password: password,
      );
      return _parseTokenResponse(response) ?? '';
    } on DioError catch (e) {
      throw MTException(code: '${e.response?.statusCode ?? '500'}', detail: e.toString());
    }
  }

  @override
  Future<String> getApiAuthTokenGoogleOauth() async {
    try {
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
    } on DioError catch (e) {
      throw MTException(code: '${e.response?.statusCode ?? '500'}', detail: e.toString());
    } catch (e) {
      // print(e.toString());
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
