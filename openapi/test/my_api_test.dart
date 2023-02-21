import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for MyApi
void main() {
  final instance = Openapi().getMyApi();

  group(MyApi, () {
    // Account
    //
    //Future<User> accountV1MyAccountGet() async
    test('test accountV1MyAccountGet', () async {
      // TODO
    });

    // Delete Account
    //
    //Future<bool> deleteAccountV1MyAccountDelete() async
    test('test deleteAccountV1MyAccountDelete', () async {
      // TODO
    });

    // Mark Read Notifications
    //
    //Future<bool> markReadNotificationsV1MyNotificationsPost(BuiltList<int> requestBody) async
    test('test markReadNotificationsV1MyNotificationsPost', () async {
      // TODO
    });

    // Notifications
    //
    //Future<BuiltList<Notification>> notificationsV1MyNotificationsGet() async
    test('test notificationsV1MyNotificationsGet', () async {
      // TODO
    });

    // Update Account
    //
    //Future<User> updateAccountV1MyAccountPost({ BodyUpdateAccountV1MyAccountPost bodyUpdateAccountV1MyAccountPost }) async
    test('test updateAccountV1MyAccountPost', () async {
      // TODO
    });

    // Update Push Token
    //
    //Future<bool> updatePushTokenV1MyPushTokenPost(BodyUpdatePushTokenV1MyPushTokenPost bodyUpdatePushTokenV1MyPushTokenPost) async
    test('test updatePushTokenV1MyPushTokenPost', () async {
      // TODO
    });

    // Workspaces
    //
    //Future<BuiltList<WorkspaceGet>> workspacesV1MyWorkspacesGet() async
    test('test workspacesV1MyWorkspacesGet', () async {
      // TODO
    });
  });
}
