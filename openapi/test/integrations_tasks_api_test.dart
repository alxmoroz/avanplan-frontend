import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for IntegrationsTasksApi
void main() {
  final instance = Openapi().getIntegrationsTasksApi();

  group(IntegrationsTasksApi, () {
    // Get Projects List
    //
    //Future<BuiltList<TaskRemote>> getProjectsListV1IntegrationsTasksGet(int wsId, int sourceId) async
    test('test getProjectsListV1IntegrationsTasksGet', () async {
      // TODO
    });

    // Import Projects
    //
    //Future<BuiltList<TaskRemote>> importProjectsV1IntegrationsTasksImportPost(int wsId, int sourceId, BuiltList<TaskRemote> taskRemote) async
    test('test importProjectsV1IntegrationsTasksImportPost', () async {
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
