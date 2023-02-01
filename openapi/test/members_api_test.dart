import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for MembersApi
void main() {
  final instance = Openapi().getMembersApi();

  group(MembersApi, () {
    // Get Task Members
    //
    //Future<BuiltList<TaskMemberRoleGet>> getTaskMembersV1MembersGet(int taskId, int wsId) async
    test('test getTaskMembersV1MembersGet', () async {
      // TODO
    });
  });
}
