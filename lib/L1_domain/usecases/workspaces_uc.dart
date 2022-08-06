// Copyright (c) 2022. Alexandr Moroz

import '../api_schema/base_upsert.dart';
import '../entities/workspace.dart';
import '../repositories/abs_api_repo.dart';

//TODO: похоже, есть смысл сделать абстрактный общий юзкейс

class WorkspacesUC {
  WorkspacesUC({required this.repo});

  final AbstractApiRepo<Workspace, BaseUpsert> repo;

  Future<List<Workspace>> getAll() async => await repo.getAll();
}
