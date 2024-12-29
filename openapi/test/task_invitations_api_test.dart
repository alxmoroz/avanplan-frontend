import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for TaskInvitationsApi
void main() {
  final instance = Openapi().getTaskInvitationsApi();

  group(TaskInvitationsApi, () {
    // Create
    //
    //Future<InvitationGet> createInvitation_1(int wsId, int taskId, Invitation invitation) async
    test('test createInvitation_1', () async {
      // TODO
    });

    // Invitations
    //
    //Future<BuiltList<InvitationGet>> getInvitations_1(int taskId, int wsId, int roleId) async
    test('test getInvitations_1', () async {
      // TODO
    });
  });
}
