import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for WSMemberContactsApi
void main() {
  final instance = Openapi().getWSMemberContactsApi();

  group(WSMemberContactsApi, () {
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
