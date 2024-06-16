// Copyright (c) 2022. Alexandr Moroz

import 'package:built_collection/built_collection.dart';
import 'package:openapi/openapi.dart';

import '../../L1_domain/entities/project_feature.dart';
import '../../L1_domain/repositories/abs_project_feature_set_repo.dart';
import '../mappers/project_feature.dart';
import '../services/api.dart';

class ProjectFeatureRepo extends AbstractProjectFeatureRepo {
  ProjectFeatureSetsApi get _api => openAPI.getProjectFeatureSetsApi();

  @override
  Future<Iterable<ProjectFeature>> setup(int wsId, int projectId, Iterable<int> optionIds) async {
    final response = await _api.setupFeatureSets(
      wsId: wsId,
      taskId: projectId,
      requestBody: BuiltList.from(optionIds),
    );
    return response.data?.map((pf) => pf.projectFeature) ?? [];
  }
}
