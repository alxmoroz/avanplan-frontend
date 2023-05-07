import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for PaymentsApi
void main() {
  final instance = Openapi().getPaymentsApi();

  group(PaymentsApi, () {
    // Iap Notification
    //
    //Future<num> iapNotificationV1PaymentsIapNotificationPost(int wsId, BodyIapNotificationV1PaymentsIapNotificationPost bodyIapNotificationV1PaymentsIapNotificationPost) async
    test('test iapNotificationV1PaymentsIapNotificationPost', () async {
      // TODO
    });
  });
}
