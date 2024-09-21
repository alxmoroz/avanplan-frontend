import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for WSMembersApi
void main() {
  final instance = Openapi().getWSMembersApi();

  group(WSMembersApi, () {
    // Delete Contact
    //
    // Удаление способа связи
    //
    //Future<bool> deleteMemberContact(int memberId, int memberContactId, int wsId, { int taskId }) async
    test('test deleteMemberContact', () async {
      // TODO
    });

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
    // Способы связи участника РП
    //
    //Future<BuiltList<MemberContactGet>> memberContacts(int memberId, int wsId, { int taskId }) async
    test('test memberContacts', () async {
      // TODO
    });

    // Upsert Contact
    //
    // Добавление / редактирование способа связи
    //
    //Future<MemberContactGet> upsertMemberContact(int memberId, int wsId, MemberContactUpsert memberContactUpsert, { int taskId }) async
    test('test upsertMemberContact', () async {
      // TODO
    });
  });
}
