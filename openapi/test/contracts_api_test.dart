import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for ContractsApi
void main() {
  final instance = Openapi().getContractsApi();

  group(ContractsApi, () {
    // Sign Contract
    //
    //Future<InvoiceGet> signContract(int wsId, int tariffId) async
    test('test signContract', () async {
      // TODO
    });

    // Sign Option
    //
    //Future<InvoiceGet> signOption(int wsId, int optionId, bool enabled) async
    test('test signOption', () async {
      // TODO
    });
  });
}
