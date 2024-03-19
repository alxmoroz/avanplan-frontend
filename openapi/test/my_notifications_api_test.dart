import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for MyNotificationsApi
void main() {
  final instance = Openapi().getMyNotificationsApi();

  group(MyNotificationsApi, () {
    // Mark Read
    //
    //Future<bool> markReadV1MyNotificationsPost(BuiltList<int> requestBody) async
    test('test markReadV1MyNotificationsPost', () async {
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
