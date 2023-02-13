// Copyright (c) 2022. Alexandr Moroz

import '../entities/role.dart';
import '../repositories/abs_ws_repo.dart';

//TODO: похоже, есть смысл сделать абстрактный общий юзкейс

class RoleUC {
  RoleUC({required this.repo});

  final AbstractWSRepo<Role> repo;

  Future<Iterable<Role>> getAll(int wsId) async => await repo.getAll(wsId);
}
