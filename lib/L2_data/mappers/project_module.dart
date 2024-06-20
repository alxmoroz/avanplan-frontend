// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../../L1_domain/entities/project_module.dart';

extension ProjectModuleMapper on ProjectFeatureSetGet {
  ProjectModule get projectModule => ProjectModule(
        id: id,
        optionId: featureSetId,
      );
}
