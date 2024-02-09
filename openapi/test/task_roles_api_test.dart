import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for TaskRolesApi
void main() {
  final instance = Openapi().getTaskRolesApi();

  group(TaskRolesApi, () {
    // Assign
    //
    //Future<BuiltList<MemberGet>> assignRole(int taskId, int wsId, int memberId, BuiltList<int> requestBody) async
    test('test assignRole', () async {
      // TODO
    });
  });
}
