import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for WSTariffsApi
void main() {
  final instance = Openapi().getWSTariffsApi();

  group(WSTariffsApi, () {
    // Available Tariffs
    //
    //Future<BuiltList<TariffGet>> availableTariffs_0(int wsId) async
    test('test availableTariffs_0', () async {
      // TODO
    });

    // Sign
    //
    //Future<InvoiceGet> sign_0(int tariffId, int wsId) async
    test('test sign_0', () async {
      // TODO
    });

    // Upsert
    //
    //Future<InvoiceGet> upsertOption_0(int wsId, int tariffId, int optionId, bool subscribe) async
    test('test upsertOption_0', () async {
      // TODO
    });
  });
}
