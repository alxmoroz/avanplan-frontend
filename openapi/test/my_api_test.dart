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

    // Delete My Messages
    //
    //Future<JsonObject> deleteMyMessagesV1MyMessagesDelete(BuiltList<int> requestBody) async
    test('test deleteMyMessagesV1MyMessagesDelete', () async {
      // TODO
    });

    // Get My Account
    //
    //Future<UserGet> getMyAccountV1MyAccountGet() async
    test('test getMyAccountV1MyAccountGet', () async {
      // TODO
    });

    // Get My Messages
    //
    //Future<BuiltList<MessageGet>> getMyMessagesV1MyMessagesGet() async
    test('test getMyMessagesV1MyMessagesGet', () async {
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
    //Future<UserGet> updateMyAccountV1MyAccountPost({ BodyUpdateMyAccountV1MyAccountPost bodyUpdateMyAccountV1MyAccountPost }) async
    test('test updateMyAccountV1MyAccountPost', () async {
      // TODO
    });

    // Update My Messages
    //
    //Future<JsonObject> updateMyMessagesV1MyMessagesPost(BuiltList<MessageUpsert> messageUpsert) async
    test('test updateMyMessagesV1MyMessagesPost', () async {
      // TODO
    });
  });
}
