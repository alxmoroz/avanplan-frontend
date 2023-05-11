import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for TasksApi
void main() {
  final instance = Openapi().getTasksApi();

  group(TasksApi, () {
    // Delete
    //
    //Future<bool> deleteV1TasksTaskIdDelete(int taskId, int wsId, { int permissionTaskId }) async
    test('test deleteV1TasksTaskIdDelete', () async {
      // TODO
    });

    // Projects
    //
    //Future<BuiltList<TaskGet>> projectsV1TasksGet(int wsId) async
    test('test projectsV1TasksGet', () async {
      // TODO
    });

    // Upsert
    //
    //Future<TaskGet> upsertV1TasksPost(int wsId, TaskUpsert taskUpsert, { String platform, int permissionTaskId }) async
    test('test upsertV1TasksPost', () async {
      // TODO
    });
  });
}
