// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/foundation.dart';
import 'package:openapi/openapi.dart' as o_api;
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../L1_domain/entities/errors.dart';
import '../../L1_domain/repositories/abs_auth_repo.dart';
import '../services/environment.dart';
import 'auth_base_repo.dart';

class AuthAppleRepo extends AbstractOAuthRepo with AuthMixin {
  @override
  Future<bool> signInIsAvailable() async => await SignInWithApple.isAvailable();

  @override
  Future<String> signIn({String? serverAuthCode}) async {
    String appleToken = '';
    String? appleEmail;
    String name = '';
    try {
      final creds = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        webAuthenticationOptions: WebAuthenticationOptions(
          redirectUri: Uri.parse(appleOauthRedirectUri),
          clientId: 'team.moroz.avanplan.services',
        ),
      );
      appleToken = creds.authorizationCode;
      appleEmail = creds.email;
      name = creds.givenName ?? '';
      if (creds.familyName != null) {
        name += name.isNotEmpty ? ' ' : '';
        name += creds.familyName!;
      }
    } on SignInWithAppleAuthorizationException catch (e) {
      if (e.code != AuthorizationErrorCode.canceled) {
        throw MTOAuthError('apple AuthorizationException', description: e.code.toString());
      }
    } on SignInWithAppleCredentialsException catch (e) {
      if (!e.message.contains('popup_closed_by_user')) {
        throw MTOAuthError('apple CredentialsException', description: e.message);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw MTOAuthError('apple', description: e.toString());
    }

    if (appleToken.isNotEmpty) {
      final response = await authApi.authAppleToken(
        bodyAuthAppleToken: (o_api.BodyAuthAppleTokenBuilder()
              ..token = appleToken
              ..email = appleEmail
              ..name = name)
            .build(),
      );
      return parseTokenResponse(response) ?? '';
    }
    return '';
  }

  @override
  Future signOut() async {}
}
