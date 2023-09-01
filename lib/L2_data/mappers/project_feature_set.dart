// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../../L1_domain/entities/project_feature_set.dart';

extension ProjectFeatureSetMapper on ProjectFeatureSetGet {
  ProjectFeatureSet get projectFeatureSet => ProjectFeatureSet(
        id: id,
        featureSetId: featureSetId,
      );
}
