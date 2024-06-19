// Copyright (c) 2022. Alexandr Moroz

import '../entities/project_module.dart';

abstract class AbstractProjectFeatureRepo {
  Future<Iterable<ProjectModule>> setup(int wsId, int projectId, Iterable<int> fIds) async => throw UnimplementedError();
}
