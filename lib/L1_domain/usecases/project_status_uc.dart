// Copyright (c) 2022. Alexandr Moroz

import '../entities/project_status.dart';
import '../repositories/abs_api_repo.dart';

class ProjectStatusUC {
  ProjectStatusUC(this.repo);

  final AbstractApiRepo<ProjectStatus, ProjectStatus> repo;

  Future<ProjectStatus?> save(ProjectStatus s) async => await repo.save(s);
  Future<ProjectStatus?> delete(ProjectStatus s) async => await repo.delete(s);
}
