// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';

class Status extends Codable {
  Status({
    required super.id,
    required super.code,
    required this.closed,
    required this.allProjects,
    required this.wsId,
  });

  bool closed;
  bool allProjects;
  final int wsId;
}
