// Copyright (c) 2022. Alexandr Moroz

import '../entities/notification.dart';
import '../entities/task.dart';
import '../entities/ws_member.dart';
import '../repositories/abs_my_repo.dart';

class MyUC {
  MyUC(this.repo);

  final AbstractMyRepo repo;

  Future<Iterable<Task>> getProjects(int wsId, {bool? imported, bool? closed}) async => await repo.getProjects(
        wsId,
        imported: imported,
        closed: closed,
      );
  Future<Iterable<Task>> getTasks(int wsId, {Task? parent, bool? closed}) async => await repo.getTasks(
        wsId,
        parent: parent,
        closed: closed,
      );

  Future<Iterable<MTNotification>> getNotifications() async => await repo.getNotifications();
  Future markReadNotifications(Iterable<int> notificationsIds) async => await repo.markReadNotifications(notificationsIds);

  Future<WSMember?> getAccount() async => await repo.getAccount();
  Future deleteAccount() async => await repo.deleteAccount();

  Future<WSMember?> registerActivity(String code, {int? wsId}) async => repo.registerActivity(code, wsId: wsId);

  Future updatePushToken(String token, bool hasPermission) async => await repo.updatePushToken(token, hasPermission);

  Future<bool> redeemInvitation(String? token) async => await repo.redeemInvitation(token);
}
