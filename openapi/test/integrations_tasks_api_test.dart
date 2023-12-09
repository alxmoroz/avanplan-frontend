import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for IntegrationsTasksApi
void main() {
  final instance = Openapi().getIntegrationsTasksApi();

  group(IntegrationsTasksApi, () {
    // Projects List
    //
    //Future<BuiltList<TaskRemote>> projectsListV1IntegrationsTasksGet(int wsId, int sourceId) async
    test('test projectsListV1IntegrationsTasksGet', () async {
      // TODO
    });

    // Start Import
    //
    //Future<bool> startImport(int wsId, BodyStartImport bodyStartImport) async
    test('test startImport', () async {
      // TODO
    });

    // Unlink
    //
    //Future<bool> unlinkV1IntegrationsTasksUnlinkPost(int taskId, int wsId) async
    test('test unlinkV1IntegrationsTasksUnlinkPost', () async {
      // TODO
    });
  });
}
