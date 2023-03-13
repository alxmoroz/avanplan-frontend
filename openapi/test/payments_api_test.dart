import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for PaymentsApi
void main() {
  final instance = Openapi().getPaymentsApi();

  group(PaymentsApi, () {
    // Ym Payment Notification
    //
    //Future<JsonObject> ymPaymentNotificationV1PaymentsYmPaymentNotificationPost({ String notificationType, String operationId, String amount, String withdrawAmount, String currency, String datetime, String sender, String codepro, String sha1Hash, String label, bool unaccepted }) async
    test('test ymPaymentNotificationV1PaymentsYmPaymentNotificationPost',
        () async {
      // TODO
    });
  });
}
