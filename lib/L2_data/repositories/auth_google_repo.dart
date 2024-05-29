// Copyright (c) 2022. Alexandr Moroz

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:openapi/openapi.dart';

import '../../L1_domain/entities/errors.dart';
import '../../L1_domain/repositories/abs_auth_repo.dart';
import '../services/platform.dart';
import 'auth_base_repo.dart';

// для андроида и iOS обязательно, если без FireBase и google-services, иначе не отдает id_token и serverAuthCode
// для веба не нужно, т.к. совпадает с его clientId (указан в index.html)
const _webServerClientId = '1039142486698-ki2e3ne2ntjfk2peqfn0r36rs489075o.apps.googleusercontent.com';

// публичный, т.к. реиспользуется при авторизации гуглового календаря
GoogleSignIn gSI({Iterable<String> scopes = const []}) => GoogleSignIn(
      scopes: [
        'email',
        'profile',
        if (scopes.isNotEmpty) ...scopes,
      ],
      //
      serverClientId: isWeb ? null : _webServerClientId,
      forceCodeForRefreshToken: true,
    );

GoogleSignIn get mainGSI => gSI();

class AuthGoogleRepo extends AbstractOAuthRepo with AuthMixin {
  @override
  Future<bool> signInIsAvailable() async {
    //TODO: костыль для возможности открывать popup для гугловой авторизации при первом посещении accounts.google.com в вебе
    final acc = await mainGSI.signInSilently();
    if (acc != null) {
      await mainGSI.signOut();
    }
    return true;
  }

  @override
  Future<String> signIn() async {
    try {
      final user = await mainGSI.signInSilently() ?? await mainGSI.signIn();
      final idToken = (await user?.authentication)?.idToken;
      if (idToken != null) {
        final Response<AuthToken> response = await authApi.authGoogleToken(
          bodyAuthGoogleToken: (BodyAuthGoogleTokenBuilder()..token = idToken).build(),
        );
        return parseTokenResponse(response) ?? '';
      }
    } on PlatformException catch (e) {
      if (e.code != 'popup_closed_by_user') {
        throw MTOAuthError('google', detail: e.code);
      }
    } catch (e) {
      throw MTOAuthError('google', detail: e.toString());
    }

    // возвращаем пустую строку, чтобы сбросить токен
    return '';
  }

  @override
  Future signOut() async => await mainGSI.disconnect();
}
