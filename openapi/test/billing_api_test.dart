import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for BillingApi
void main() {
  final instance = Openapi().getBillingApi();

  group(BillingApi, () {
    // Ym Payment Notification
    //
    //Future<JsonObject> ymPaymentNotificationV1BillingYmPaymentNotificationPost({ String notificationType, String operationId, String amount, String withdrawAmount, String currency, String datetime, String sender, String codepro, String sha1Hash, String label, bool unaccepted }) async
    test('test ymPaymentNotificationV1BillingYmPaymentNotificationPost',
        () async {
      // TODO
    });
  });
}
