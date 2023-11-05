// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';

class Status extends Codable {
  Status({
    required super.id,
    required super.code,
    required this.closed,
    required this.wsId,
  });

  bool closed;
  final int wsId;
}
