import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for IntegrationsSourcesApi
void main() {
  final instance = Openapi().getIntegrationsSourcesApi();

  group(IntegrationsSourcesApi, () {
    // Delete Source
    //
    //Future<JsonObject> deleteSourceV1IntegrationsSourcesSourceIdDelete(int sourceId) async
    test('test deleteSourceV1IntegrationsSourcesSourceIdDelete', () async {
      // TODO
    });

    // Get Source Types
    //
    //Future<BuiltList<SourceTypeGet>> getSourceTypesV1IntegrationsSourcesTypesGet() async
    test('test getSourceTypesV1IntegrationsSourcesTypesGet', () async {
      // TODO
    });

    // Upsert Source
    //
    //Future<SourceGet> upsertSourceV1IntegrationsSourcesPost(SourceUpsert sourceUpsert) async
    test('test upsertSourceV1IntegrationsSourcesPost', () async {
      // TODO
    });
  });
}
