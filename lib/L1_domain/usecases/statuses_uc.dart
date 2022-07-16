// Copyright (c) 2022. Alexandr Moroz

import '../entities/base_entity.dart';
import '../entities/status.dart';
import '../repositories/abs_api_repo.dart';

abstract class StatusesUC<S extends Statusable> {
  StatusesUC({required this.repo});

  final AbstractApiRepo<S, dynamic> repo;
}

class TaskStatusesUC extends StatusesUC<Status> {
  TaskStatusesUC({required AbstractApiRepo<Status, dynamic> repo}) : super(repo: repo);
}
