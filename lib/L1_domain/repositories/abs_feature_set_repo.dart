// Copyright (c) 2022. Alexandr Moroz

import '../entities/feature_set.dart';
import '../entities/task.dart';

abstract class AbstractFeatureSetRepo {
  Future<Iterable<FeatureSet>> getAll() async => throw UnimplementedError();
  Future<Iterable<ProjectFeatureSet>> setup(Task project, Iterable<int> fsIds) async => throw UnimplementedError();
}
