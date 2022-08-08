import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for IntegrationsTasksApi
void main() {
  final instance = Openapi().getIntegrationsTasksApi();

  group(IntegrationsTasksApi, () {
    // Get Root Tasks
    //
    //Future<BuiltList<Task>> getRootTasksV1IntegrationsTasksGet(int sourceId) async
    test('test getRootTasksV1IntegrationsTasksGet', () async {
      // TODO
    });

    // Import Task Sources
    //
    //Future<Msg> importTaskSourcesV1IntegrationsTasksImportPost(int sourceId, BuiltList<TaskSource> taskSource) async
    test('test importTaskSourcesV1IntegrationsTasksImportPost', () async {
      // TODO
    });

    // Update Task Sources
    //
    //Future<Msg> updateTaskSourcesV1IntegrationsTasksUpdateTaskSourcesPost(int sourceId, BuiltList<TaskSource> taskSource) async
    test('test updateTaskSourcesV1IntegrationsTasksUpdateTaskSourcesPost',
        () async {
      // TODO
    });
  });
}
