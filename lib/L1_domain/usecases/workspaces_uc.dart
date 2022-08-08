// Copyright (c) 2022. Alexandr Moroz

import '../entities/workspace.dart';
import '../repositories/abs_api_repo.dart';

//TODO: похоже, есть смысл сделать абстрактный общий юзкейс

class WorkspacesUC {
  WorkspacesUC({required this.repo});

  final AbstractApiRepo<Workspace> repo;

  Future<List<Workspace>> getAll() async => await repo.getAll();
}
