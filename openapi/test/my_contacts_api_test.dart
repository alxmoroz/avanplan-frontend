import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for MyContactsApi
void main() {
  final instance = Openapi().getMyContactsApi();

  group(MyContactsApi, () {
    // Delete My Contact
    //
    // Удаление способа связи пользователя
    //
    //Future<bool> deleteMyContact(int userContactId) async
    test('test deleteMyContact', () async {
      // TODO
    });

    // My Contacts
    //
    // Способы связи пользователя
    //
    //Future<BuiltList<UserContactGet>> myContacts() async
    test('test myContacts', () async {
      // TODO
    });

    // Upsert My Contact
    //
    // Добавление / редактирование способа связи пользователя
    //
    //Future<UserContactGet> upsertMyContact(UserContactUpsert userContactUpsert) async
    test('test upsertMyContact', () async {
      // TODO
    });
  });
}
