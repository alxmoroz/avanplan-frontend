// Copyright (c) 2022. Alexandr Moroz

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:openapi/openapi.dart';

import '../../L1_domain/system/errors.dart';
import '../services/platform.dart';
import 'auth_base_repo.dart';

class AuthGoogleRepo extends AuthBaseRepo {
  // для андроида обязательно, если без FireBase и google-services, иначе не отдает id_token
  static String serverClientID = '1039142486698-ki2e3ne2ntjfk2peqfn0r36rs489075o.apps.googleusercontent.com';

  GoogleSignIn get _gSI => GoogleSignIn(
        scopes: ['email', 'profile'],
        serverClientId: isAndroid ? serverClientID : null,
      );

  @override
  Future<bool> signInIsAvailable() async {
    // костыль для возможности открывать popup для гугловой авторизации при первом посещении accounts.google.com
    final acc = await _gSI.signInSilently();
    if (acc != null) {
      await _gSI.signOut();
    }
    return true;
  }

  @override
  Future<String> signIn({String? locale, String? email, String? pwd, bool? invited}) async {
    GoogleSignInAuthentication? auth;
    try {
      final account = await _gSI.signInSilently() ?? await _gSI.signIn();
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
                ..token = token
                ..platform = platformCode
                ..locale = locale ?? 'ru')
              .build(),
        );
        return parseTokenResponse(response) ?? '';
      }
    }
    return '';
  }

  @override
  Future signOut() async => await _gSI.disconnect();
}
