// Copyright (c) 2022. Alexandr Moroz

import 'package:built_collection/built_collection.dart';
import 'package:openapi/openapi.dart' as o_api;

import '../../L1_domain/entities/notification.dart';
import '../../L1_domain/entities/user.dart';
import '../../L1_domain/entities/workspace.dart';
import '../../L1_domain/repositories/abs_api_my_repo.dart';
import '../mappers/notification.dart';
import '../mappers/user.dart';
import '../mappers/workspace.dart';
import '../mappers/ws_role.dart';
import '../services/api.dart';
import '../services/platform.dart';

class MyRepo extends AbstractApiMyRepo {
  o_api.MyApi get api => openAPI.getMyApi();

  @override
  Future<User?> getMyAccount() async {
    User? user;
    final response = await api.getMyAccountV1MyAccountGet();
    if (response.statusCode == 200) {
      user = response.data?.user;
    }
    return user;
  }

  @override
  Future deleteMyAccount() async => await api.deleteMyAccountV1MyAccountDelete();

  @override
  Future<Iterable<Workspace>> getMyWorkspaces() async {
    final response = await api.getMyWorkspacesV1MyWorkspacesGet();

    final Map<int, Workspace> workspacesMap = {};
    if (response.statusCode == 200) {
      // берем запись, смотрим id её РП. Если такая уже есть у нас, то берём её и в её список ролей добавляем роль из записи.
      // если нет, то создаём и добавляем роль туда
      for (o_api.WSUserRole wsUserRole in response.data ?? []) {
        final wsId = wsUserRole.workspace.id;
        final role = wsUserRole.role.wsRole;
        if (workspacesMap[wsId] == null) {
          workspacesMap[wsId] = wsUserRole.workspace.workspace;
        }
        workspacesMap[wsId]!.roles.add(role);
      }
    }
    return workspacesMap.values;
  }

  @override
  Future<Iterable<MTNotification>> getMyNotifications() async {
    final response = await api.getMyNotificationsV1MyNotificationsGet();
    return response.data?.map((n) => n.notification) ?? [];
  }

  @override
  Future readMyMessages(Iterable<int> messagesIds) async {
    await api.readMyMessagesV1MyMessagesPost(requestBody: BuiltList.from(messagesIds));
  }

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
