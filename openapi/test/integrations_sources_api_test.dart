import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for IntegrationsSourcesApi
void main() {
  final instance = Openapi().getIntegrationsSourcesApi();

  group(IntegrationsSourcesApi, () {
    // Check Connection
    //
    //Future<bool> checkConnectionV1IntegrationsSourcesCheckConnectionGet(int wsId, int sourceId) async
    test('test checkConnectionV1IntegrationsSourcesCheckConnectionGet',
        () async {
      // TODO
    });

    // Delete Source
    //
    //Future<JsonObject> deleteSourceV1IntegrationsSourcesSourceIdDelete(int sourceId, int wsId) async
    test('test deleteSourceV1IntegrationsSourcesSourceIdDelete', () async {
      // TODO
    });

    // Get Sources
    //
    //Future<BuiltList<SourceGet>> getSourcesV1IntegrationsSourcesGet(int wsId) async
    test('test getSourcesV1IntegrationsSourcesGet', () async {
      // TODO
    });

    // Upsert Source
    //
    //Future<SourceGet> upsertSourceV1IntegrationsSourcesPost(int wsId, SourceUpsert sourceUpsert) async
    test('test upsertSourceV1IntegrationsSourcesPost', () async {
      // TODO
    });
  });
}
