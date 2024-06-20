// Copyright (c) 2022. Alexandr Moroz

import '../entities/project_module.dart';
import '../repositories/abs_project_module_repo.dart';

class ProjectModuleUC {
  ProjectModuleUC(this.repo);

  final AbstractProjectModuleRepo repo;

  Future<Iterable<ProjectModule>> setup(int wsId, int projectId, Iterable<int> optionsIds) async => await repo.setup(wsId, projectId, optionsIds);
}
