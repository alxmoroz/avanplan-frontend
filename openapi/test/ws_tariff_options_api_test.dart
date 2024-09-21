import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for WSTariffOptionsApi
void main() {
  final instance = Openapi().getWSTariffOptionsApi();

  group(WSTariffOptionsApi, () {
    // Upsert
    //
    //Future<InvoiceGet> upsertOption(int wsId, int tariffId, int optionId, bool subscribe) async
    test('test upsertOption', () async {
      // TODO
    });
  });
}
