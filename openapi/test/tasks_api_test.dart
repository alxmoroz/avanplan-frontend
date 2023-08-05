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

    // Task Upsert
    //
    //Future<TaskGet> taskUpsertV1TasksPost(int wsId, TaskUpsert taskUpsert, { int permissionTaskId }) async
    test('test taskUpsertV1TasksPost', () async {
      // TODO
    });
  });
}
