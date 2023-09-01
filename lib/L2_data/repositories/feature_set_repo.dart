// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart' as o_api;

import '../../L1_domain/entities/feature_set.dart';
import '../../L1_domain/repositories/abs_feature_set_repo.dart';
import '../mappers/feature_set.dart';
import '../services/api.dart';

class FeatureSetRepo extends AbstractFeatureSetRepo {
  o_api.FeatureSetsApi get api => openAPI.getFeatureSetsApi();

  @override
  Future<Iterable<FeatureSet>> getAll() async {
    final response = await api.featureSetsV1FeatureSetsGet();
    return response.data?.map((fs) => fs.featureSet) ?? [];
  }
}
