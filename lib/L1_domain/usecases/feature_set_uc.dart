// Copyright (c) 2022. Alexandr Moroz

import '../entities/feature_set.dart';
import '../repositories/abs_feature_set_repo.dart';

class FeatureSetUC {
  FeatureSetUC(this.repo);

  final AbstractFeatureSetRepo repo;

  Future<Iterable<FeatureSet>> getAll() async => await repo.getAll();
}
