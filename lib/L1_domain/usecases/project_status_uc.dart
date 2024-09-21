// Copyright (c) 2024. Alexandr Moroz

import '../entities/project_status.dart';
import '../repositories/abs_project_status_repo.dart';

class ProjectStatusesUC {
  ProjectStatusesUC(this.repo);

  final AbstractProjectStatusesRepo repo;

  Future<int> statusTasksCount(int wsId, int projectId, int statusId) async => await repo.statusTasksCount(wsId, projectId, statusId);
  Future<ProjectStatus?> save(ProjectStatus s) async => await repo.save(s);
  Future<ProjectStatus?> delete(ProjectStatus s) async => await repo.delete(s);
}
