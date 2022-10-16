import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for AuthApi
void main() {
  final instance = Openapi().getAuthApi();

  group(AuthApi, () {
    // Token
    //
    //Future<Token> authToken(String username, String password, { String grantType, String scope, String clientId, String clientSecret }) async
    test('test authToken', () async {
      // TODO
    });

    // Token Google Oauth
    //
    //Future<Token> authTokenGoogleOauth(BodyAuthTokenGoogleOauth bodyAuthTokenGoogleOauth) async
    test('test authTokenGoogleOauth', () async {
      // TODO
    });
  });
}
