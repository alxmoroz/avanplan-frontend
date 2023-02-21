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
  o_api.MyApi get api => openAPI.getMyApi();

  @override
  Future<User?> getMyAccount() async {
    final response = await api.accountV1MyAccountGet();
    return response.data?.user;
  }

  @override
  Future deleteMyAccount() async => await api.deleteAccountV1MyAccountDelete();

  @override
  Future<Iterable<Workspace>> getMyWorkspaces() async {
    final response = await api.workspacesV1MyWorkspacesGet();
    return response.data?.map((ws) => ws.workspace) ?? [];
  }

  @override
  Future<Iterable<MTNotification>> getMyNotifications() async {
    final response = await api.notificationsV1MyNotificationsGet();
    return response.data?.map((n) => n.notification) ?? [];
  }

  @override
  Future markReadNotifications(Iterable<int> notificationsIds) async =>
      await api.markReadNotificationsV1MyNotificationsPost(requestBody: BuiltList.from(notificationsIds));

  @override
  Future updatePushToken(String token, bool hasPermission) async {
    final body = (o_api.BodyUpdatePushTokenV1MyPushTokenPostBuilder()
          ..platform = platformCode
          ..code = token
          ..hasPermission = hasPermission)
        .build();
    await api.updatePushTokenV1MyPushTokenPost(bodyUpdatePushTokenV1MyPushTokenPost: body);
  }
}
