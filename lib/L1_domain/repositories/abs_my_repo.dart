// Copyright (c) 2024. Alexandr Moroz

import '../entities/notification.dart';
import '../entities/task.dart';
import '../entities/user.dart';

abstract class AbstractMyRepo {
  Future<User?> getAccount();
  Future deleteAccount();

  Future<User?> registerActivity(String code, {int? wsId});

  Future<Iterable<MTNotification>> getNotifications();
  Future markReadNotifications(Iterable<int> notificationsIds);

  Future updatePushToken(String token, bool hasPermission);

  Future<TaskDescriptor?> redeemInvitation(String? token);
}
