// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';

class ProjectStatus extends Titleable {
  ProjectStatus({
    required super.id,
    required super.title,
    super.description,
    required this.position,
    required this.closed,
  });

  int position;
  bool closed;
}
