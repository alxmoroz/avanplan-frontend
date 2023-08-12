// Copyright (c) 2022. Alexandr Moroz

import 'package:built_collection/built_collection.dart';
import 'package:openapi/openapi.dart' as o_api;

import '../../L1_domain/entities/notification.dart';
import '../../L1_domain/entities/task.dart';
import '../../L1_domain/entities/user.dart';
import '../../L1_domain/entities/workspace.dart';
import '../../L1_domain/repositories/abs_my_repo.dart';
import '../mappers/notification.dart';
import '../mappers/task.dart';
import '../mappers/user.dart';
import '../mappers/workspace.dart';
import '../services/api.dart';
import '../services/platform.dart';

class MyRepo extends AbstractMyRepo {
  o_api.MyAccountApi get _accountApi => openAPI.getMyAccountApi();
  o_api.MyInvitationsApi get _invitationsApi => openAPI.getMyInvitationsApi();
  o_api.MyActivitiesApi get _activitiesApi => openAPI.getMyActivitiesApi();
  o_api.MyWorkspacesApi get _wsApi => openAPI.getMyWorkspacesApi();
  o_api.MyNotificationsApi get _notificationsApi => openAPI.getMyNotificationsApi();
  o_api.MyPushTokensApi get _pushTokensApi => openAPI.getMyPushTokensApi();
  o_api.MyTasksApi get _tasksApi => openAPI.getMyTasksApi();

  @override
  Future<User?> getAccount() async {
    final response = await _accountApi.accountV1MyAccountGet();
    return response.data?.myUser(-1);
  }

  @override
  Future deleteAccount() async => await _accountApi.deleteAccountV1MyAccountDelete();

  @override
  Future<Iterable<Workspace>> getWorkspaces() async {
    final response = await _wsApi.workspacesV1MyWorkspacesGet();
    return response.data?.map((ws) => ws.workspace) ?? [];
  }

  @override
  Future<Iterable<Task>> getTasks(Workspace ws, {int? parentId, bool? closed}) async {
    final response = await _tasksApi.myTasksV1MyTasksGet(wsId: ws.id!, parentId: parentId, closed: closed);
    return response.data?.map((t) => t.task(ws: ws)) ?? [];
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
    final response = await _wsApi.createWorkspaceV1MyWorkspacesCreatePost(workspaceUpsert: wsData);
    return response.data?.workspace;
  }

  @override
  Future<Workspace?> updateWorkspace(WorkspaceUpsert ws) async {
    final response = await _wsApi.updateWorkspaceV1MyWorkspacesUpdatePost(
        wsId: ws.id!,
        workspaceUpsert: (o_api.WorkspaceUpsertBuilder()
              ..id = ws.id
              ..code = ws.code
              ..title = ws.title
              ..description = ws.description)
            .build());
    return response.data?.workspace;
  }

  @override
  Future<Iterable<MTNotification>> getNotifications() async {
    final response = await _notificationsApi.myNotificationsV1MyNotificationsGet();
    return response.data?.map((n) => n.notification) ?? [];
  }

  @override
  Future markReadNotifications(Iterable<int> notificationsIds) async =>
      await _notificationsApi.markReadNotificationsV1MyNotificationsPost(requestBody: BuiltList.from(notificationsIds));

  @override
  Future updatePushToken(String token, bool hasPermission) async {
    final body = (o_api.BodyUpdatePushTokenV1MyPushTokensPostBuilder()
          ..platform = platformCode
          ..code = token
          ..hasPermission = hasPermission)
        .build();
    await _pushTokensApi.updatePushTokenV1MyPushTokensPost(bodyUpdatePushTokenV1MyPushTokensPost: body);
  }

  @override
  Future redeemInvitation(String? token) async {
    final body = (o_api.BodyRedeemV1MyInvitationsRedeemPostBuilder()..invitationToken = token).build();
    final response = await _invitationsApi.redeemV1MyInvitationsRedeemPost(bodyRedeemV1MyInvitationsRedeemPost: body);
    return response.data == true;
  }

  @override
  Future<User?> registerActivity(String code, {int? wsId}) async {
    final body = (o_api.BodyRegisterV1MyActivitiesRegisterPostBuilder()
          ..code = code
          ..wsId = wsId)
        .build();
    final response = await _activitiesApi.registerV1MyActivitiesRegisterPost(bodyRegisterV1MyActivitiesRegisterPost: body);
    return response.data?.myUser(-1);
  }
}
