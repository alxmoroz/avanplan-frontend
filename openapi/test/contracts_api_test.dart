import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for ContractsApi
void main() {
  final instance = Openapi().getContractsApi();

  group(ContractsApi, () {
    // Sign
    //
    //Future<InvoiceGet> signV1ContractsSignPost(int tariffId, int wsId) async
    test('test signV1ContractsSignPost', () async {
      // TODO
    });
  });
}
