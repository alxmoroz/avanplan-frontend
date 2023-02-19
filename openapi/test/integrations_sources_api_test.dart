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

    // Delete
    //
    //Future<bool> deleteV1IntegrationsSourcesSourceIdDelete(int sourceId, int wsId) async
    test('test deleteV1IntegrationsSourcesSourceIdDelete', () async {
      // TODO
    });

    // Sources
    //
    //Future<BuiltList<SourceGet>> sourcesV1IntegrationsSourcesGet(int wsId) async
    test('test sourcesV1IntegrationsSourcesGet', () async {
      // TODO
    });

    // Upsert
    //
    //Future<SourceGet> upsertV1IntegrationsSourcesPost(int wsId, SourceUpsert sourceUpsert) async
    test('test upsertV1IntegrationsSourcesPost', () async {
      // TODO
    });
  });
}
