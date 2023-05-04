import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for Deprecated11Api
void main() {
  final instance = Openapi().getDeprecated11Api();

  group(Deprecated11Api, () {
    // Deprecated Invitation Create
    //
    //Future<String> deprecatedInvitationCreateV1InvitationPost(int wsId, Invitation invitation) async
    test('test deprecatedInvitationCreateV1InvitationPost', () async {
      // TODO
    });

    // Deprecated Roles Assign
    //
    //Future<BuiltList<MemberGet>> deprecatedRolesAssignV1RolesPost(int taskId, int memberId, int wsId, BuiltList<int> requestBody, { int permissionTaskId }) async
    test('test deprecatedRolesAssignV1RolesPost', () async {
      // TODO
    });
  });
}
