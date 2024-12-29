import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for WSSourcesApi
void main() {
  final instance = Openapi().getWSSourcesApi();

  group(WSSourcesApi, () {
    // Check Connection
    //
    //Future<bool> checkConnection_0(int wsId, int sourceId) async
    test('test checkConnection_0', () async {
      // TODO
    });

    // Delete
    //
    //Future<bool> deleteSource_0(int sourceId, int wsId) async
    test('test deleteSource_0', () async {
      // TODO
    });

    // Get Projects
    //
    //Future<BuiltList<TaskRemote>> getProjects_0(int wsId, int sourceId) async
    test('test getProjects_0', () async {
      // TODO
    });

    // Request Type
    //
    //Future<bool> requestType_0(int wsId, BodyRequestType bodyRequestType) async
    test('test requestType_0', () async {
      // TODO
    });

    // Start Import
    //
    //Future<bool> startImport_0(int wsId, int sourceId, BodyStartImport bodyStartImport) async
    test('test startImport_0', () async {
      // TODO
    });

    // Upsert
    //
    //Future<SourceGet> upsertSource_0(int wsId, SourceUpsert sourceUpsert) async
    test('test upsertSource_0', () async {
      // TODO
    });
  });
}
