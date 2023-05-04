import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for TasksRolesApi
void main() {
  final instance = Openapi().getTasksRolesApi();

  group(TasksRolesApi, () {
    // Assign
    //
    //Future<BuiltList<MemberGet>> assignV1TasksRolesPost(int taskId, int memberId, int wsId, BuiltList<int> requestBody, { int permissionTaskId }) async
    test('test assignV1TasksRolesPost', () async {
      // TODO
    });
  });
}
