// Copyright (c) 2022. Alexandr Moroz

import '../entities/project_module.dart';
import '../repositories/abs_project_modules_repo.dart';

class ProjectModulesUC {
  ProjectModulesUC(this.repo);

  final AbstractProjectModulesRepo repo;

  Future<Iterable<ProjectModule>> setup(int wsId, int projectId, Iterable<String> toCodes) async => await repo.setup(wsId, projectId, toCodes);
}
