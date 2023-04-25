// Copyright (c) 2022. Alexandr Moroz

import '../entities/notification.dart';
import '../entities/user.dart';
import '../entities/workspace.dart';
import '../repositories/abs_my_repo.dart';

class MyUC {
  MyUC(this.repo);
  Future<MyUC> init() async => this;

  final AbstractMyRepo repo;

  Future<Iterable<Workspace>> getWorkspaces() async => await repo.getMyWorkspaces();
  Future<Workspace?> createWorkspace({WorkspaceUpsert? ws}) async => await repo.createWorkspace(ws: ws);
  Future<Workspace?> updateWorkspace(WorkspaceUpsert ws) async => await repo.updateWorkspace(ws);
  Future<Iterable<MTNotification>> getNotifications() async => await repo.getMyNotifications();
  Future markReadNotifications(Iterable<int> notificationsIds) async => await repo.markReadNotifications(notificationsIds);
  Future<User?> getMyAccount() async => await repo.getMyAccount();
  Future deleteMyAccount() async => await repo.deleteMyAccount();
  Future updatePushToken(String token, bool hasPermission) async => await repo.updatePushToken(token, hasPermission);
  Future<bool> redeemInvitation(String? token) async => await repo.redeemInvitation(token);
}
