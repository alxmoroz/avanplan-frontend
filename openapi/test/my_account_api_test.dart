import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for MyAccountApi
void main() {
  final instance = Openapi().getMyAccountApi();

  group(MyAccountApi, () {
    // Account
    //
    //Future<MyUser> accountV1MyAccountGet() async
    test('test accountV1MyAccountGet', () async {
      // TODO
    });

    // Delete Account
    //
    //Future<bool> deleteAccountV1MyAccountDelete() async
    test('test deleteAccountV1MyAccountDelete', () async {
      // TODO
    });
  });
}
