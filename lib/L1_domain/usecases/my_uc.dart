// Copyright (c) 2022. Alexandr Moroz

import '../entities/message.dart';
import '../entities/user.dart';
import '../entities/workspace.dart';
import '../repositories/abs_api_my_repo.dart';

class MyUC {
  MyUC({required this.repo});

  final AbstractApiMyRepo repo;

  Future<Iterable<Workspace>> getWorkspaces() async => await repo.getMyWorkspaces();
  Future<Iterable<EventMessage>> getMessages() async => await repo.getMyMessages();
  Future updateMessages(Iterable<EventMessage> messages) async => await repo.updateMessages(messages);
  Future<User?> getMyAccount() async => await repo.getMyAccount();
  Future deleteMyAccount() async => await repo.deleteMyAccount();
}
