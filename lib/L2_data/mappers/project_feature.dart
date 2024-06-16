// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../../L1_domain/entities/project_feature.dart';

extension ProjectFeatureMapper on ProjectFeatureSetGet {
  ProjectFeature get projectFeature => ProjectFeature(
        id: id,
        optionId: featureSetId,
      );
}
