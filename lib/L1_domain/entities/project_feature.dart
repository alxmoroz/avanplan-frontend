// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';

class ProjectFeature extends RPersistable {
  ProjectFeature({
    required super.id,
    required this.optionId,
  });

  final int optionId;
}
