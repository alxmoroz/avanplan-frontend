import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for IntegrationsTasksApi
void main() {
  final instance = Openapi().getIntegrationsTasksApi();

  group(IntegrationsTasksApi, () {
    // Import Task Sources
    //
    //Future<bool> importTaskSourcesV1IntegrationsTasksImportPost(int wsId, int sourceId, BuiltList<TaskSource> taskSource) async
    test('test importTaskSourcesV1IntegrationsTasksImportPost', () async {
      // TODO
    });

    // Root Tasks
    //
    //Future<BuiltList<TaskRemote>> rootTasksV1IntegrationsTasksGet(int wsId, int sourceId) async
    test('test rootTasksV1IntegrationsTasksGet', () async {
      // TODO
    });

    // Update Task Sources
    //
    //Future<bool> updateTaskSourcesV1IntegrationsTasksUpdateTaskSourcesPost(int wsId, BuiltList<TaskSourceUpsert> taskSourceUpsert) async
    test('test updateTaskSourcesV1IntegrationsTasksUpdateTaskSourcesPost',
        () async {
      // TODO
    });
  });
}
