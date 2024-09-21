// Copyright (c) 2022. Alexandr Moroz

import '../entities/project_module.dart';

abstract class AbstractProjectModulesRepo {
  Future<Iterable<ProjectModule>> setup(int wsId, int projectId, Iterable<String> toCodes) async => throw UnimplementedError();
}
