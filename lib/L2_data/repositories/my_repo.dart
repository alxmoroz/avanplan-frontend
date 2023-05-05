// Copyright (c) 2022. Alexandr Moroz

import 'package:built_collection/built_collection.dart';
import 'package:openapi/openapi.dart' as o_api;

import '../../L1_domain/entities/notification.dart';
import '../../L1_domain/entities/user.dart';
import '../../L1_domain/entities/workspace.dart';
import '../../L1_domain/repositories/abs_my_repo.dart';
import '../mappers/notification.dart';
import '../mappers/user.dart';
import '../mappers/workspace.dart';
import '../services/api.dart';
import '../services/platform.dart';

class MyRepo extends AbstractMyRepo {
  o_api.MyAccountApi get myAccountApi => openAPI.getMyAccountApi();
  @override
  Future<User?> getMyAccount() async {
    final response = await myAccountApi.accountV1MyAccountGet();
    return response.data?.user(-1);
  }

  @override
  Future deleteMyAccount() async => await myAccountApi.deleteAccountV1MyAccountDelete();

  o_api.MyWorkspacesApi get myWSApi => openAPI.getMyWorkspacesApi();
  @override
  Future<Iterable<Workspace>> getMyWorkspaces() async {
    final response = await myWSApi.workspacesV1MyWorkspacesGet();
    return response.data?.map((ws) => ws.workspace) ?? [];
  }

  @override
  Future<Workspace?> createWorkspace({WorkspaceUpsert? ws}) async {
    o_api.WorkspaceUpsert? wsData;
    if (ws != null) {
      wsData = (o_api.WorkspaceUpsertBuilder()
            ..code = ws.code
            ..title = ws.title
            ..description = ws.description)
          .build();
    }
    final response = await myWSApi.createWorkspaceV1MyWorkspacesCreatePost(workspaceUpsert: wsData);
    return response.data?.workspace;
  }

  @override
  Future<Workspace?> updateWorkspace(WorkspaceUpsert ws) async {
    final response = await myWSApi.updateWorkspaceV1MyWorkspacesUpdatePost(
        wsId: ws.id!,
        workspaceUpsert: (o_api.WorkspaceUpsertBuilder()
              ..id = ws.id
              ..code = ws.code
              ..title = ws.title
              ..description = ws.description)
            .build());
    return response.data?.workspace;
  }

  o_api.MyNotificationsApi get myNotificationsApi => openAPI.getMyNotificationsApi();
  @override
  Future<Iterable<MTNotification>> getMyNotifications() async {
    final response = await myNotificationsApi.notificationsV1MyNotificationsGet();
    return response.data?.map((n) => n.notification) ?? [];
  }

  @override
  Future markReadNotifications(Iterable<int> notificationsIds) async =>
      await myNotificationsApi.markReadNotificationsV1MyNotificationsPost(requestBody: BuiltList.from(notificationsIds));

  o_api.MyPushTokensApi get myPushTokensApi => openAPI.getMyPushTokensApi();
  @override
  Future updatePushToken(String token, bool hasPermission) async {
    final body = (o_api.BodyUpdatePushTokenV1MyPushTokensUpdatePostBuilder()
          ..platform = platformCode
          ..code = token
          ..hasPermission = hasPermission)
        .build();
    await myPushTokensApi.updatePushTokenV1MyPushTokensUpdatePost(bodyUpdatePushTokenV1MyPushTokensUpdatePost: body);
  }

  o_api.MyInvitationsApi get myInvitationsApi => openAPI.getMyInvitationsApi();
  @override
  Future redeemInvitation(String? token) async {
    final body = (o_api.BodyRedeemV1MyInvitationsRedeemPostBuilder()..invitationToken = token).build();
    final response = await myInvitationsApi.redeemV1MyInvitationsRedeemPost(bodyRedeemV1MyInvitationsRedeemPost: body);
    return response.data == true;
  }
}
