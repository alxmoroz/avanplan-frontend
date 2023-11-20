import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for TasksInvitationsApi
void main() {
  final instance = Openapi().getTasksInvitationsApi();

  group(TasksInvitationsApi, () {
    // Create
    //
    //Future<InvitationGet> createInvitation(int wsId, int taskId, Invitation invitation) async
    test('test createInvitation', () async {
      // TODO
    });

    // Invitations
    //
    //Future<BuiltList<InvitationGet>> getInvitations(int taskId, int wsId, int roleId) async
    test('test getInvitations', () async {
      // TODO
    });
  });
}
