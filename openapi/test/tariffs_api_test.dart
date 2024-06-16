import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for TariffsApi
void main() {
  final instance = Openapi().getTariffsApi();

  group(TariffsApi, () {
    // Available Tariffs
    //
    //Future<BuiltList<TariffGet>> availableTariffs(int wsId) async
    test('test availableTariffs', () async {
      // TODO
    });

    // Sign
    //
    //Future<InvoiceGet> sign(int tariffId, int wsId) async
    test('test sign', () async {
      // TODO
    });

    // Upsert
    //
    //Future<InvoiceGet> upsertOption(int wsId, int tariffId, int optionId, bool subscribe) async
    test('test upsertOption', () async {
      // TODO
    });
  });
}
