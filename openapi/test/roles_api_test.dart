import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for RolesApi
void main() {
  final instance = Openapi().getRolesApi();

  group(RolesApi, () {
    // Assign
    //
    //Future<BuiltList<MemberGet>> assignV1RolesAssignPost(int taskId, int memberId, int wsId, BuiltList<int> requestBody, { int permissionTaskId }) async
    test('test assignV1RolesAssignPost', () async {
      // TODO
    });
  });
}
