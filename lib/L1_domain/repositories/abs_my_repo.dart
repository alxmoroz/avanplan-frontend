// Copyright (c) 2024. Alexandr Moroz

import '../entities/notification.dart';
import '../entities/user.dart';

abstract class AbstractMyRepo {
  Future<User?> getAccount() async => throw UnimplementedError();
  Future<User?> registerActivity(String code, {int? wsId}) async => throw UnimplementedError();
  Future deleteAccount() async => throw UnimplementedError();

  Future<Iterable<MTNotification>> getNotifications() async => throw UnimplementedError();
  Future markReadNotifications(Iterable<int> notificationsIds) async => throw UnimplementedError();
  Future updatePushToken(String token, bool hasPermission) async => throw UnimplementedError();
  Future redeemInvitation(String? token) async => throw UnimplementedError();
}
