// Copyright (c) 2022. Alexandr Moroz

import '../entities/user.dart';
import '../entities/workspace.dart';
import '../repositories/abs_api_my_repo.dart';

class MyUC {
  MyUC({required this.repo});

  final AbstractApiMyRepo repo;

  Future<Iterable<Workspace>> getWorkspaces() async => await repo.getMyWorkspaces();
  Future<User?> getMyAccount() async => await repo.getMyAccount();
}
