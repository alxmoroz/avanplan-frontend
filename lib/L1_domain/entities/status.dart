// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';

class Status extends Codable {
  Status({
    required super.id,
    required super.code,
    required this.closed,
  });

  bool closed;
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
