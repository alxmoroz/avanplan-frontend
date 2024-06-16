// Copyright (c) 2022. Alexandr Moroz

import '../entities/project_feature.dart';
import '../repositories/abs_project_feature_repo.dart';

class ProjectFeatureUC {
  ProjectFeatureUC(this.repo);

  final AbstractProjectFeatureRepo repo;

  Future<Iterable<ProjectFeature>> setup(int wsId, int projectId, Iterable<int> fIds) async => await repo.setup(wsId, projectId, fIds);
}
