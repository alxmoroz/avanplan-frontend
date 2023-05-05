import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for Deprecated11Api
void main() {
  final instance = Openapi().getDeprecated11Api();

  group(Deprecated11Api, () {
    // Deprecated Create Workspace
    //
    //Future<WorkspaceGet> deprecatedCreateWorkspaceV1MyCreateWorkspacePost({ WorkspaceUpsert workspaceUpsert }) async
    test('test deprecatedCreateWorkspaceV1MyCreateWorkspacePost', () async {
      // TODO
    });

    // Deprecated Invitation Create
    //
    //Future<String> deprecatedInvitationCreateV1InvitationPost(int wsId, Invitation invitation) async
    test('test deprecatedInvitationCreateV1InvitationPost', () async {
      // TODO
    });

    // Deprecated Redeem Invitation
    //
    //Future<bool> deprecatedRedeemInvitationV1MyRedeemInvitationPost({ BodyDeprecatedRedeemInvitationV1MyRedeemInvitationPost bodyDeprecatedRedeemInvitationV1MyRedeemInvitationPost }) async
    test('test deprecatedRedeemInvitationV1MyRedeemInvitationPost', () async {
      // TODO
    });

    // Deprecated Roles Assign
    //
    //Future<BuiltList<MemberGet>> deprecatedRolesAssignV1RolesPost(int taskId, int memberId, int wsId, BuiltList<int> requestBody, { int permissionTaskId }) async
    test('test deprecatedRolesAssignV1RolesPost', () async {
      // TODO
    });

    // Deprecated Update Push Token
    //
    //Future<bool> deprecatedUpdatePushTokenV1MyPushTokenPost(BodyDeprecatedUpdatePushTokenV1MyPushTokenPost bodyDeprecatedUpdatePushTokenV1MyPushTokenPost) async
    test('test deprecatedUpdatePushTokenV1MyPushTokenPost', () async {
      // TODO
    });

    // Deprecated Update Workspace
    //
    //Future<WorkspaceGet> deprecatedUpdateWorkspaceV1MyUpdateWorkspacePost(int wsId, WorkspaceUpsert workspaceUpsert) async
    test('test deprecatedUpdateWorkspaceV1MyUpdateWorkspacePost', () async {
      // TODO
    });
  });
}
