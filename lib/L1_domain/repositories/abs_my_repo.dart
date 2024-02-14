// Copyright (c) 2022. Alexandr Moroz

import '../entities/notification.dart';
import '../entities/task.dart';
import '../entities/ws_member.dart';

abstract class AbstractMyRepo {
  Future<WSMember?> getAccount();
  Future<WSMember?> registerActivity(String code, {int? wsId});
  Future deleteAccount();

  Future<Iterable<Task>> getProjects(int wsId, {bool? closed, bool? imported});
  Future<Iterable<Task>> getTasks(int wsId, {Task? parent, bool? closed});

  Future<Iterable<MTNotification>> getNotifications();
  Future markReadNotifications(Iterable<int> notificationsIds);
  Future updatePushToken(String token, bool hasPermission);
  Future redeemInvitation(String? token);
}
