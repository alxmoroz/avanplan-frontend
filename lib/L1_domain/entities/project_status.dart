// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';

class ProjectStatus extends RPersistable {
  ProjectStatus({
    required super.id,
    required this.statusId,
    required this.position,
  });

  final int position;
  final int statusId;
}
