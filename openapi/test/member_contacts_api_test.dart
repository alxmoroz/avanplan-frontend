import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for MemberContactsApi
void main() {
  final instance = Openapi().getMemberContactsApi();

  group(MemberContactsApi, () {
    // Delete Contact
    //
    // Удаление способа связи
    //
    //Future<bool> deleteMemberContact(int memberId, int memberContactId, int wsId, { int taskId }) async
    test('test deleteMemberContact', () async {
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
