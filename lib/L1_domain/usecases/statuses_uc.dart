// Copyright (c) 2022. Alexandr Moroz

import '../entities/base_entity.dart';
import '../entities/task_status.dart';
import '../repositories/abs_api_repo.dart';

abstract class StatusesUC<S extends Statusable> {
  StatusesUC({required this.repo});

  final AbstractApiRepo<S, dynamic> repo;
}

class TaskStatusesUC extends StatusesUC<TaskStatus> {
  TaskStatusesUC({required AbstractApiRepo<TaskStatus, dynamic> repo}) : super(repo: repo);
}
