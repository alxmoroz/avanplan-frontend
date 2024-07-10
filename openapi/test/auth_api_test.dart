import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for AuthApi
void main() {
  final instance = Openapi().getAuthApi();

  group(AuthApi, () {
    // Apple Token
    //
    //Future<AuthToken> authAppleToken(BodyAuthAppleToken bodyAuthAppleToken) async
    test('test authAppleToken', () async {
      // TODO
    });

    // Google Token
    //
    //Future<AuthToken> authGoogleToken(BodyAuthGoogleToken bodyAuthGoogleToken) async
    test('test authGoogleToken', () async {
      // TODO
    });

    // Yandex Token
    //
    //Future<AuthToken> authYandexToken(BodyAuthYandexToken bodyAuthYandexToken) async
    test('test authYandexToken', () async {
      // TODO
    });

    // Password Token
    //
    //Future<AuthToken> passwordToken(String username, String password, { String grantType, String scope, String clientId, String clientSecret }) async
    test('test passwordToken', () async {
      // TODO
    });

    // Refresh Token
    //
    //Future<AuthToken> refreshToken() async
    test('test refreshToken', () async {
      // TODO
    });

    // Registration Token
    //
    //Future<AuthToken> registrationToken(BodyRegistrationToken bodyRegistrationToken) async
    test('test registrationToken', () async {
      // TODO
    });

    // Request Registration
    //
    //Future<bool> requestRegistration(BodyRequestRegistration bodyRequestRegistration) async
    test('test requestRegistration', () async {
      // TODO
    });
  });
}
