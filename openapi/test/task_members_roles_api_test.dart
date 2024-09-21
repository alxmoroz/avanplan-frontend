import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for TaskMembersRolesApi
void main() {
  final instance = Openapi().getTaskMembersRolesApi();

  group(TaskMembersRolesApi, () {
    // Assign Member Roles
    //
    //Future<BuiltList<MemberGet>> assignMemberRoles(int taskId, int wsId, int memberId, BuiltList<int> requestBody) async
    test('test assignMemberRoles', () async {
      // TODO
    });
  });
}
