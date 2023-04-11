// Copyright (c) 2022. Alexandr Moroz

import '../entities/notification.dart';
import '../entities/user.dart';
import '../entities/workspace.dart';

abstract class AbstractMyRepo {
  Future<User?> getMyAccount();
  Future deleteMyAccount();
  Future<Iterable<Workspace>> getMyWorkspaces();
  Future<Iterable<MTNotification>> getMyNotifications();
  Future markReadNotifications(Iterable<int> notificationsIds);
  Future updatePushToken(String token, bool hasPermission);
  Future redeemInvitation(String token);
}
