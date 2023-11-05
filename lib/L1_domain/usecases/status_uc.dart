// Copyright (c) 2022. Alexandr Moroz

import '../entities/status.dart';
import '../repositories/abs_api_repo.dart';

class StatusUC {
  StatusUC(this.repo);

  final AbstractApiRepo<Status, Status> repo;

  Future<Iterable<Status>> getAll(int wsId) async => await repo.getAllWithWS(wsId);
  Future<Status?> save(Status s) async => await repo.save(s);
  Future<Status?> delete(Status s) async => await repo.delete(s);
}
