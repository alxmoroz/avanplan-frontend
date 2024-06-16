import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for TariffOptionsApi
void main() {
  final instance = Openapi().getTariffOptionsApi();

  group(TariffOptionsApi, () {
    // Upsert
    //
    //Future<InvoiceGet> upsertOption(int wsId, int tariffId, int optionId, bool enabled) async
    test('test upsertOption', () async {
      // TODO
    });
  });
}
