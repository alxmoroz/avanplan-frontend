// Copyright (c) 2022. Alexandr Moroz

import 'package:built_collection/built_collection.dart';
import 'package:openapi/openapi.dart' as o_api;

import '../../L1_domain/entities/feature_set.dart';
import '../../L1_domain/entities/task.dart';
import '../../L1_domain/repositories/abs_feature_set_repo.dart';
import '../mappers/feature_set.dart';
import '../services/api.dart';

class FeatureSetRepo extends AbstractFeatureSetRepo {
  o_api.FeatureSetsApi get api => openAPI.getFeatureSetsApi();
  o_api.ProjectFeatureSetsApi get pfsApi => openAPI.getProjectFeatureSetsApi();

  @override
  Future<Iterable<FeatureSet>> getAll() async {
    final response = await api.featureSetsV1RefsFeatureSetsGet();
    return response.data?.map((fs) => fs.featureSet) ?? [];
  }

  @override
  Future<Iterable<ProjectFeatureSet>> setup(Task project, Iterable<int> fsIds) async {
    final projectId = project.id!;
    final response = await pfsApi.setupFeatureSetsV1TasksFeatureSetsPost(
      projectId: projectId,
      permissionTaskId: projectId,
      wsId: project.wsId,
      requestBody: BuiltList.from(fsIds),
    );
    return response.data?.map((pfs) => pfs.projectFeatureSet) ?? [];
  }
}
