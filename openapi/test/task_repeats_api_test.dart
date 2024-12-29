import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for TaskRepeatsApi
void main() {
  final instance = Openapi().getTaskRepeatsApi();

  group(TaskRepeatsApi, () {
    // Delete
    //
    //Future<bool> deleteRepeat_1(int wsId, int taskId, int repeatId) async
    test('test deleteRepeat_1', () async {
      // TODO
    });

    // Upsert
    //
    //Future<TaskRepeatGet> upsertRepeat_1(int wsId, int taskId, TaskRepeatUpsert taskRepeatUpsert) async
    test('test upsertRepeat_1', () async {
      // TODO
    });
  });
}
