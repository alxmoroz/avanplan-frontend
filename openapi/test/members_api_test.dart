import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for MembersApi
void main() {
  final instance = Openapi().getMembersApi();

  group(MembersApi, () {
    // Member Assigned Tasks
    //
    // Задачи участника РП
    //
    //Future<BuiltList<TaskGet>> memberAssignedTasks(int memberId, int wsId, { int taskId }) async
    test('test memberAssignedTasks', () async {
      // TODO
    });
  });
}
