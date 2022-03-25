// Copyright (c) 2022. Alexandr Moroz

import '../entities/goals/task_status.dart';
import '../repositories/abs_api_repo.dart';

class TaskStatusesUC {
  TaskStatusesUC({required this.repo});

  final AbstractApiRepo<TaskStatus, dynamic> repo;

  Future<List<TaskStatus>> getStatuses() async {
    return await repo.getAll();
  }
}
