import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for IntegrationsSourcesApi
void main() {
  final instance = Openapi().getIntegrationsSourcesApi();

  group(IntegrationsSourcesApi, () {
    // Request Source Type
    //
    //Future<bool> requestSourceType(BodyRequestSourceType bodyRequestSourceType) async
    test('test requestSourceType', () async {
      // TODO
    });

    // Check Connection
    //
    //Future<bool> sourcesCheckConnection(int wsId, int sourceId) async
    test('test sourcesCheckConnection', () async {
      // TODO
    });

    // Delete
    //
    //Future<bool> sourcesDelete(int sourceId, int wsId) async
    test('test sourcesDelete', () async {
      // TODO
    });

    // Upsert
    //
    //Future<SourceGet> sourcesUpsert(int wsId, SourceUpsert sourceUpsert) async
    test('test sourcesUpsert', () async {
      // TODO
    });
  });
}
