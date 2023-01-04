// Copyright (c) 2022. Alexandr Moroz

import '../entities/notification.dart';
import '../entities/user.dart';
import '../entities/workspace.dart';
import '../repositories/abs_api_my_repo.dart';

class MyUC {
  MyUC({required this.repo});

  final AbstractApiMyRepo repo;

  Future<Iterable<Workspace>> getWorkspaces() async => await repo.getMyWorkspaces();
  Future<Iterable<MTNotification>> getNotifications() async => await repo.getMyNotifications();
  Future readMyMessages(Iterable<int> messagesIds) async => await repo.readMyMessages(messagesIds);
  Future<User?> getMyAccount() async => await repo.getMyAccount();
  Future deleteMyAccount() async => await repo.deleteMyAccount();
}
