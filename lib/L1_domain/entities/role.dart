// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';

class Role extends Codable {
  Role({
    required super.id,
    required super.code,
  });

  bool selected = false;
}
