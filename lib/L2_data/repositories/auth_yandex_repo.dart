// Copyright (c) 2024. Alexandr Moroz

import 'package:avanplan_api/avanplan_api.dart';

import '../../L1_domain/entities/errors.dart';
import '../../L1_domain/repositories/abs_auth_repo.dart';
import '../services/environment.dart';
import 'auth_base_repo.dart';

class AuthYandexRepo extends AbstractOAuthRepo with AuthMixin {
  AuthYandexRepo(super.lsRepo);

  @override
  Future<bool> signInIsAvailable() async => true;

  @override
  Uri get serverAuthCodeUri => Uri.https(
        'oauth.yandex.ru',
        'authorize',
        {
          'client_id': 'e8acb1168464432fa7ff626fdf3106aa',
          'response_type': 'code',
          'redirect_uri': '$yandexOauthRedirectUri',
          'force_confirm': 'true',
        },
      );

  @override
  Future<String> signIn({String? serverAuthCode}) async {
    try {
      if (serverAuthCode != null) {
        final response = await authApi.authYandexToken(
          bodyAuthYandexToken: (BodyAuthYandexTokenBuilder()..serverAuthCode = serverAuthCode).build(),
        );
        return parseTokenResponse(response) ?? '';
      }
    } catch (e) {
      throw MTOAuthError('yandex', detail: e.toString());
    }

    // возвращаем пустую строку, чтобы сбросить токен
    return '';
  }

  @override
  Future signOut({bool disconnect = false}) async => {};
}
