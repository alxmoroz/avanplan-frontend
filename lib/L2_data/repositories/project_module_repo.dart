// Copyright (c) 2022. Alexandr Moroz

import 'package:built_collection/built_collection.dart';
import 'package:openapi/openapi.dart';

import '../../L1_domain/entities/project_module.dart';
import '../../L1_domain/repositories/abs_project_module_repo.dart';
import '../mappers/project_module.dart';
import '../services/api.dart';

class ProjectModulesRepo extends AbstractProjectModuleRepo {
  ProjectFeatureSetsApi get _api => openAPI.getProjectFeatureSetsApi();

  @override
  Future<Iterable<ProjectModule>> setup(int wsId, int projectId, Iterable<int> optionsIds) async {
    final response = await _api.setupProjectFeatureSets(
      wsId: wsId,
      taskId: projectId,
      requestBody: BuiltList.from(optionsIds),
    );
    return response.data?.map((pf) => pf.projectModule) ?? [];
  }
}
