// Copyright (c) 2022. Alexandr Moroz

import '../entities/notification.dart';
import '../entities/user.dart';
import '../entities/workspace.dart';

abstract class AbstractMyRepo {
  Future<User?> getAccount();
  Future<User?> registerActivity(String code, {int? wsId});
  Future deleteAccount();
  Future<Iterable<Workspace>> getWorkspaces();
  Future<Workspace?> createWorkspace({WorkspaceUpsert? ws});
  Future<Workspace?> updateWorkspace(WorkspaceUpsert ws);
  Future<Iterable<MTNotification>> getNotifications();
  Future markReadNotifications(Iterable<int> notificationsIds);
  Future updatePushToken(String token, bool hasPermission);
  Future redeemInvitation(String? token);
}
