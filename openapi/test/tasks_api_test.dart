import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for TasksApi
void main() {
  final instance = Openapi().getTasksApi();

  group(TasksApi, () {
    // Delete Task
    //
    //Future<JsonObject> deleteTaskV1TasksTaskIdDelete(int taskId) async
    test('test deleteTaskV1TasksTaskIdDelete', () async {
      // TODO
    });

    // Get Root Tasks
    //
    //Future<BuiltList<TaskGet>> getRootTasksV1TasksGet(int wsId) async
    test('test getRootTasksV1TasksGet', () async {
      // TODO
    });

    // Unlink Tasks
    //
    //Future<TaskGet> unlinkTasksV1TasksUnlinkPost(TaskUpsert taskUpsert) async
    test('test unlinkTasksV1TasksUnlinkPost', () async {
      // TODO
    });

    // Upsert Task
    //
    //Future<TaskGet> upsertTaskV1TasksPost(TaskUpsert taskUpsert) async
    test('test upsertTaskV1TasksPost', () async {
      // TODO
    });
  });
}
