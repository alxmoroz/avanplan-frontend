// Copyright (c) 2024. Alexandr Moroz

import '../entities/notification.dart';
import '../entities/task.dart';
import '../entities/user.dart';
import '../repositories/abs_my_repo.dart';

class MyUC {
  MyUC(this.repo);

  final AbstractMyRepo repo;

  Future<Iterable<MTNotification>> getNotifications() async => await repo.getNotifications();
  Future markReadNotifications(Iterable<int> notificationsIds) async => await repo.markReadNotifications(notificationsIds);

  Future<User?> getAccount() async => await repo.getAccount();
  Future deleteAccount() async => await repo.deleteAccount();

  // Future<User?> registerActivity(String code, {int? wsId}) async => repo.registerActivity(code, wsId: wsId);

  Future updatePushToken(String token, bool hasPermission) async => await repo.updatePushToken(token, hasPermission);

  Future<TaskDescriptor?> redeemInvitation(String? token) async => await repo.redeemInvitation(token);
}
