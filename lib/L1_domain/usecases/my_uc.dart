// Copyright (c) 2022. Alexandr Moroz

import '../entities/notification.dart';
import '../entities/task.dart';
import '../entities/user.dart';
import '../entities/workspace.dart';
import '../repositories/abs_my_repo.dart';

class MyUC {
  MyUC(this.repo);

  final AbstractMyRepo repo;

  Future<Iterable<Workspace>> getWorkspaces() async => await repo.getWorkspaces();
  Future<Iterable<Task>> getTasks(Workspace ws, {Task? parent, bool? closed}) async => await repo.getTasks(ws, parent: parent, closed: closed);

  Future<Workspace?> createWorkspace({WorkspaceUpsert? ws}) async => await repo.createWorkspace(ws: ws);
  Future<Workspace?> updateWorkspace(WorkspaceUpsert ws) async => await repo.updateWorkspace(ws);

  Future<Iterable<MTNotification>> getNotifications() async => await repo.getNotifications();
  Future markReadNotifications(Iterable<int> notificationsIds) async => await repo.markReadNotifications(notificationsIds);

  Future<User?> getAccount() async => await repo.getAccount();
  Future deleteAccount() async => await repo.deleteAccount();

  Future<User?> registerActivity(String code, {int? wsId}) async => repo.registerActivity(code, wsId: wsId);

  Future updatePushToken(String token, bool hasPermission) async => await repo.updatePushToken(token, hasPermission);

  Future<bool> redeemInvitation(String? token) async => await repo.redeemInvitation(token);
}
