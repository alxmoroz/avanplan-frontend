// Copyright (c) 2022. Alexandr Moroz

import '../api_schema/base_upsert.dart';
import '../entities/auth/workspace.dart';
import '../repositories/abs_api_repo.dart';

class WorkspacesUC {
  WorkspacesUC({required this.repo});

  final AbstractApiRepo<Workspace, BaseUpsert> repo;

  Future<List<Workspace>> getAll() async {
    return await repo.getAll();
  }
}
