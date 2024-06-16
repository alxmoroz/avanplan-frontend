// Copyright (c) 2022. Alexandr Moroz

import '../entities/project_feature.dart';

abstract class AbstractProjectFeatureRepo {
  Future<Iterable<ProjectFeature>> setup(int wsId, int projectId, Iterable<int> fIds) async => throw UnimplementedError();
}
