import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for WSMembersApi
void main() {
  final instance = Openapi().getWSMembersApi();

  group(WSMembersApi, () {
    // Ws Member Assigned Tasks
    //
    // Задачи участника РП
    //
    //Future<BuiltList<TaskGet>> memberAssignedTasks(int memberId, int wsId, { int taskId }) async
    test('test memberAssignedTasks', () async {
      // TODO
    });
  });
}
