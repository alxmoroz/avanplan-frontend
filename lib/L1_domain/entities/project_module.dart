// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';

class ProjectModule extends RPersistable {
  ProjectModule({
    required super.id,
    required this.optionId,
  });

  final int optionId;
}
