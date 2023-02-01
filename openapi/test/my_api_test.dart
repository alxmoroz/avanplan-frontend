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
    //Future<User> getMyAccountV1MyAccountGet() async
    test('test getMyAccountV1MyAccountGet', () async {
      // TODO
    });

    // Get My Notifications
    //
    //Future<BuiltList<Notification>> getMyNotificationsV1MyNotificationsGet() async
    test('test getMyNotificationsV1MyNotificationsGet', () async {
      // TODO
    });

    // Get My Workspaces
    //
    //Future<BuiltList<WSUserRole>> getMyWorkspacesV1MyWorkspacesGet() async
    test('test getMyWorkspacesV1MyWorkspacesGet', () async {
      // TODO
    });

    // Read My Messages
    //
    //Future<JsonObject> readMyMessagesV1MyMessagesPost(BuiltList<int> requestBody) async
    test('test readMyMessagesV1MyMessagesPost', () async {
      // TODO
    });

    // Update My Account
    //
    //Future<User> updateMyAccountV1MyAccountPost({ BodyUpdateMyAccountV1MyAccountPost bodyUpdateMyAccountV1MyAccountPost }) async
    test('test updateMyAccountV1MyAccountPost', () async {
      // TODO
    });

    // Update Push Token
    //
    //Future<JsonObject> updatePushTokenV1MyPushTokenPost(BodyUpdatePushTokenV1MyPushTokenPost bodyUpdatePushTokenV1MyPushTokenPost) async
    test('test updatePushTokenV1MyPushTokenPost', () async {
      // TODO
    });
  });
}
