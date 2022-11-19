import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for MyApi
void main() {
  final instance = Openapi().getMyApi();

  group(MyApi, () {
    // Delete My Account
    //
    //Future<JsonObject> deleteMyAccountV1MyAccountDelete() async
    test('test deleteMyAccountV1MyAccountDelete', () async {
      // TODO
    });

    // Get My Account
    //
    //Future<UserGet> getMyAccountV1MyAccountGet() async
    test('test getMyAccountV1MyAccountGet', () async {
      // TODO
    });

    // Get My Workspaces
    //
    //Future<BuiltList<WSUserRoleGet>> getMyWorkspacesV1MyWorkspacesGet() async
    test('test getMyWorkspacesV1MyWorkspacesGet', () async {
      // TODO
    });

    // Update My Account
    //
    //Future<UserGet> updateMyAccountV1MyAccountPut({ BodyUpdateMyAccountV1MyAccountPut bodyUpdateMyAccountV1MyAccountPut }) async
    test('test updateMyAccountV1MyAccountPut', () async {
      // TODO
    });
  });
}
