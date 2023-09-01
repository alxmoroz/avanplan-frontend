// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';

class ProjectFeatureSet extends RPersistable {
  ProjectFeatureSet({
    required super.id,
    required this.featureSetId,
  });

  final int featureSetId;
}
