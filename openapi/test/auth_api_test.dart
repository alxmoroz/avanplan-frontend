import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for AuthApi
void main() {
  final instance = Openapi().getAuthApi();

  group(AuthApi, () {
    // Apple Token
    //
    //Future<Token> authAppleToken(String locale, BodyAuthAppleToken bodyAuthAppleToken) async
    test('test authAppleToken', () async {
      // TODO
    });

    // Google Token
    //
    //Future<Token> authGoogleToken(String locale, BodyAuthGoogleToken bodyAuthGoogleToken) async
    test('test authGoogleToken', () async {
      // TODO
    });

    // Token
    //
    //Future<Token> authToken(String username, String password, { String grantType, String scope, String clientId, String clientSecret }) async
    test('test authToken', () async {
      // TODO
    });

    // Refresh Token
    //
    //Future<Token> refreshToken() async
    test('test refreshToken', () async {
      // TODO
    });
  });
}
