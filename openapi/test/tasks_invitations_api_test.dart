import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for TasksInvitationsApi
void main() {
  final instance = Openapi().getTasksInvitationsApi();

  group(TasksInvitationsApi, () {
    // Create
    //
    //Future<InvitationGet> createV1TasksInvitationsPost(int wsId, Invitation invitation) async
    test('test createV1TasksInvitationsPost', () async {
      // TODO
    });

    // Invitations
    //
    //Future<BuiltList<InvitationGet>> invitationsV1TasksInvitationsGet(int taskId, int roleId, int wsId, { int permissionTaskId }) async
    test('test invitationsV1TasksInvitationsGet', () async {
      // TODO
    });
  });
}
