// Copyright (c) 2022. Alexandr Moroz

import 'package:built_collection/built_collection.dart';
import 'package:openapi/openapi.dart';

import '../../L1_domain/entities/project_module.dart';
import '../../L1_domain/repositories/abs_project_module_repo.dart';
import '../mappers/project_module.dart';
import '../services/api.dart';

class ProjectModulesRepo extends AbstractProjectModuleRepo {
  ProjectModulesApi get _api => openAPI.getProjectModulesApi();

  @override
  Future<Iterable<ProjectModule>> setup(int wsId, int projectId, Iterable<String> toCodes) async {
    final response = await _api.setupProjectModules(
      wsId: wsId,
      taskId: projectId,
      requestBody: BuiltList.from(toCodes),
    );
    return response.data?.map((pf) => pf.projectModule) ?? [];
  }
}
