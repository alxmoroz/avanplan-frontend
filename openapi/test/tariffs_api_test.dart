import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for TariffsApi
void main() {
  final instance = Openapi().getTariffsApi();

  group(TariffsApi, () {
    // Tariffs
    //
    //Future<BuiltList<TariffGet>> tariffsV1TariffsGet(int wsId) async
    test('test tariffsV1TariffsGet', () async {
      // TODO
    });
  });
}
