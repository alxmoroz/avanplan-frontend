import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for SourcesApi
void main() {
  final instance = Openapi().getSourcesApi();

  group(SourcesApi, () {
    // Check Connection
    //
    //Future<bool> checkConnection(int wsId, int sourceId) async
    test('test checkConnection', () async {
      // TODO
    });

    // Delete
    //
    //Future<bool> deleteSource(int sourceId, int wsId) async
    test('test deleteSource', () async {
      // TODO
    });

    // Get Projects
    //
    //Future<BuiltList<TaskRemote>> getProjects(int wsId, int sourceId) async
    test('test getProjects', () async {
      // TODO
    });

    // Request Type
    //
    //Future<bool> requestType(int wsId, BodyRequestType bodyRequestType) async
    test('test requestType', () async {
      // TODO
    });

    // Start Import
    //
    //Future<bool> startImport(int wsId, int sourceId, BodyStartImport bodyStartImport) async
    test('test startImport', () async {
      // TODO
    });

    // Upsert
    //
    //Future<SourceGet> upsertSource(int wsId, SourceUpsert sourceUpsert) async
    test('test upsertSource', () async {
      // TODO
    });
  });
}
