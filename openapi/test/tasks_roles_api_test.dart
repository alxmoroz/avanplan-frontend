import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for TasksRolesApi
void main() {
  final instance = Openapi().getTasksRolesApi();

  group(TasksRolesApi, () {
    // Assign
    //
    //Future<BuiltList<MemberGet>> assignRole(int taskId, int wsId, int memberId, BuiltList<int> requestBody) async
    test('test assignRole', () async {
      // TODO
    });
  });
}
