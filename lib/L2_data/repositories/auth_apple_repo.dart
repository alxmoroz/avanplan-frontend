// Copyright (c) 2022. Alexandr Moroz

import 'package:dio/dio.dart';
import 'package:openapi/openapi.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../L1_domain/system/errors.dart';
import '../services/platform.dart';
import 'auth_base_repo.dart';

class AuthAppleRepo extends AuthBaseRepo {
  @override
  Future<bool> signInIsAvailable() async => await SignInWithApple.isAvailable();

  @override
  Future<String> signIn({String? login, String? pwd, String? locale}) async {
    String appleToken = '';
    String? email;
    String name = '';
    try {
      final creds = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        webAuthenticationOptions: WebAuthenticationOptions(
          redirectUri: Uri.parse('https://avanplan.ru'),
          clientId: 'team.moroz.avanplan.services',
        ),
      );
      appleToken = creds.authorizationCode;
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

    if (appleToken.isNotEmpty) {
      final Response<Token> response = await authApi.authAppleToken(
        bodyAuthAppleToken: (BodyAuthAppleTokenBuilder()
              ..appleToken = appleToken
              ..platform = platformCode
              ..email = email
              ..name = name)
            .build(),
        locale: locale ?? 'ru',
      );
      return parseTokenResponse(response) ?? '';
    }
    return '';
  }

  @override
  Future signOut() async {}
}
