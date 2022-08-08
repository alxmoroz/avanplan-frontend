import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for AuthApi
void main() {
  final instance = Openapi().getAuthApi();

  group(AuthApi, () {
    // Token
    //
    // OAuth2 token login, access token for future requests
    //
    //Future<Token> getAuthToken(String username, String password, { String grantType, String scope, String clientId, String clientSecret }) async
    test('test getAuthToken', () async {
      // TODO
    });
  });
}
