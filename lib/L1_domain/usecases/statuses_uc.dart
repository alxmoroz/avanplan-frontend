// Copyright (c) 2022. Alexandr Moroz

import '../entities/base_entity.dart';
import '../entities/ew_status.dart';
import '../repositories/abs_api_repo.dart';

abstract class StatusesUC<S extends Statusable> {
  StatusesUC({required this.repo});

  final AbstractApiRepo<S, dynamic> repo;
}

class TaskStatusesUC extends StatusesUC<EWStatus> {
  TaskStatusesUC({required AbstractApiRepo<EWStatus, dynamic> repo}) : super(repo: repo);
}
