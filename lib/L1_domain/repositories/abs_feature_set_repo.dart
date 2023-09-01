// Copyright (c) 2022. Alexandr Moroz

import '../entities/feature_set.dart';

abstract class AbstractFeatureSetRepo {
  Future<Iterable<FeatureSet>> getAll();
}
