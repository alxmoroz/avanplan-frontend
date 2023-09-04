// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';

class Status extends Statusable {
  Status({
    required super.id,
    required super.code,
    required super.closed,
  });
}

class ProjectStatus extends RPersistable {
  ProjectStatus({
    required super.id,
    required this.statusId,
    required this.position,
  });

  final int position;
  final int statusId;
}
