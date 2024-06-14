// Copyright (c) 2022. Alexandr Moroz

import '../entities/feature_set.dart';
import '../entities/task.dart';
import '../repositories/abs_feature_set_repo.dart';

// TODO: deprecated

class FeatureSetUC {
  FeatureSetUC(this.repo);

  final AbstractFeatureSetRepo repo;

  Future<Iterable<FeatureSet>> getAll() async => await repo.getAll();
  Future<Iterable<ProjectFeatureSet>> setup(Task project, Iterable<int> fsIds) async => await repo.setup(project, fsIds);
}
