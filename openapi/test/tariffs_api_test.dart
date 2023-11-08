import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for TariffsApi
void main() {
  final instance = Openapi().getTariffsApi();

  group(TariffsApi, () {
    // Available Tariffs
    //
    //Future<BuiltList<TariffGet>> getAvailableTariffs(int wsId) async
    test('test getAvailableTariffs', () async {
      // TODO
    });
  });
}
