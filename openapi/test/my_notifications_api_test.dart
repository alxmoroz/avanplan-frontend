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

    // Notifications
    //
    //Future<BuiltList<Notification>> notificationsV1MyNotificationsGet() async
    test('test notificationsV1MyNotificationsGet', () async {
      // TODO
    });
  });
}
