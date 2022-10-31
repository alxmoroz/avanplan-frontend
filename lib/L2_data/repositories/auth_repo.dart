// Copyright (c) 2022. Alexandr Moroz

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:openapi/openapi.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../L1_domain/repositories/abs_api_auth_repo.dart';
import '../../L1_domain/system/errors.dart';
import 'api.dart';
import 'platform.dart';

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

  @override
  Future<String> getApiAuthGoogleToken() async {
    GoogleSignInAuthentication? auth;
    try {
      final googleAuth = GoogleSignIn(scopes: ['email', 'profile']);
      GoogleSignInAccount? account;
      if (!await googleAuth.isSignedIn()) {
        account = await googleAuth.signIn();
      } else {
        account = await googleAuth.signInSilently();
      }
      auth = await account?.authentication;
    } on PlatformException catch (e) {
      if (e.code != 'popup_closed_by_user') {
        throw MTOAuthError(code: 'google', detail: e.code);
      }
    } catch (e) {
      throw MTOAuthError(code: 'google', detail: e.toString());
    }

    if (auth != null) {
      final token = auth.idToken;
      if (token != null) {
        final Response<Token> response = await api.authGoogleToken(
          bodyAuthGoogleToken: (BodyAuthGoogleTokenBuilder()
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
  Future<bool> authWithAppleIsAvailable() async => await SignInWithApple.isAvailable();

  @override
  Future<String> getApiAuthAppleToken() async {
    String token = '';
    String? email;
    String name = '';
    try {
      final creds = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        webAuthenticationOptions: WebAuthenticationOptions(
          redirectUri: Uri.parse('https://gercul.es'),
          clientId: 'team.moroz.gercules.services',
        ),
      );
      token = creds.authorizationCode;
      email = creds.email;
      name = creds.givenName ?? '';
      if (creds.familyName != null) {
        name += name.isNotEmpty ? ' ' : '';
        name += creds.familyName!;
      }
    } on SignInWithAppleAuthorizationException catch (e) {
      if (e.code != AuthorizationErrorCode.canceled) {
        throw MTOAuthError(code: 'apple AuthorizationException', detail: e.code.toString());
      }
    } on SignInWithAppleCredentialsException catch (e) {
      if (!e.message.contains('popup_closed_by_user')) {
        throw MTOAuthError(code: 'apple CredentialsException', detail: e.message);
      }
    } catch (e) {
      print(e);
      throw MTOAuthError(code: 'apple', detail: e.toString());
    }

    if (token.isNotEmpty) {
      final Response<Token> response = await api.authAppleToken(
        bodyAuthAppleToken: (BodyAuthAppleTokenBuilder()
              ..appleToken = token
              ..platform = platformCode
              ..email = email
              ..name = name)
            .build(),
      );
      return _parseTokenResponse(response) ?? '';
    }

    return '';
  }

  @override
  Future logout() async {
    await GoogleSignIn().signOut();
  }

  @override
  void setApiCredentials(String token) {
    openAPI.setOAuthToken('OAuth2PasswordBearer', token);
  }
}
