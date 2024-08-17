import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for TaskRepeatsApi
void main() {
  final instance = Openapi().getTaskRepeatsApi();

  group(TaskRepeatsApi, () {
    // Delete
    //
    //Future<bool> deleteRepeat(int wsId, int taskId, int repeatId) async
    test('test deleteRepeat', () async {
      // TODO
    });

    // Upsert
    //
    //Future<TaskRepeatGet> upsertRepeat(int wsId, int taskId, TaskRepeatUpsert taskRepeatUpsert) async
    test('test upsertRepeat', () async {
      // TODO
    });
  });
}
