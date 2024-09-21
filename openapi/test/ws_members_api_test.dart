import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for WSMembersApi
void main() {
  final instance = Openapi().getWSMembersApi();

  group(WSMembersApi, () {
    // Member Assigned Tasks
    //
    // Задачи участника РП
    //
    //Future<BuiltList<TaskGet>> memberAssignedTasks(int memberId, int wsId, { int taskId }) async
    test('test memberAssignedTasks', () async {
      // TODO
    });

    // Member Contacts
    //
    // Способы связи участника РП в проекте
    //
    //Future<BuiltList<MemberContactGet>> memberContacts(int memberId, int wsId, { int taskId }) async
    test('test memberContacts', () async {
      // TODO
    });
  });
}
