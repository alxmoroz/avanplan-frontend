// Copyright (c) 2022. Alexandr Moroz

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:openapi/openapi.dart';

import '../../L1_domain/system/errors.dart';
import 'auth_base_repo.dart';
import 'platform.dart';

class AuthGoogleRepo extends AuthBaseRepo {
  GoogleSignIn get _gSI => GoogleSignIn(scopes: ['email', 'profile']);

  @override
  Future<bool> signInIsAvailable() async => true;

  @override
  Future<String> signIn({String? username, String? password}) async {
    GoogleSignInAuthentication? auth;
    try {
      final googleAuth = _gSI;
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
        final Response<Token> response = await authApi.authGoogleToken(
          bodyAuthGoogleToken: (BodyAuthGoogleTokenBuilder()
                ..googleToken = token
                ..platform = platformCode)
              .build(),
        );
        return parseTokenResponse(response) ?? '';
      }
    }
    return '';
  }

  @override
  Future signOut() async => await _gSI.signOut();
}
