import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for MyNotificationsApi
void main() {
  final instance = Openapi().getMyNotificationsApi();

  group(MyNotificationsApi, () {
    // Mark Read Notifications
    //
    //Future<bool> markReadNotificationsV1MyNotificationsPost(BuiltList<int> requestBody) async
    test('test markReadNotificationsV1MyNotificationsPost', () async {
      // TODO
    });

    // My Notifications
    //
    //Future<BuiltList<Notification>> myNotificationsV1MyNotificationsGet() async
    test('test myNotificationsV1MyNotificationsGet', () async {
      // TODO
    });
  });
}
