import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for ProjectMembersApi
void main() {
  final instance = Openapi().getProjectMembersApi();

  group(ProjectMembersApi, () {
    // Assign Project Member Roles
    //
    //Future<BuiltList<MemberGet>> assignProjectMemberRoles_1(int taskId, int memberId, int wsId, BuiltList<int> requestBody) async
    test('test assignProjectMemberRoles_1', () async {
      // TODO
    });

    // Project Member Contacts
    //
    // Способы связи участника РП в проекте
    //
    //Future<BuiltList<MemberContactGet>> projectMemberContacts_1(int memberId, int wsId, int taskId) async
    test('test projectMemberContacts_1', () async {
      // TODO
    });
  });
}
