// Copyright (c) 2022. Alexandr Moroz

import 'package:intl/intl.dart';

import 'base_entity.dart';

class Role extends Codable {
  Role({
    required super.id,
    required super.code,
  });

  bool selected = false;

  String get title => Intl.message('role_${code.toLowerCase()}_title');
  String get description => Intl.message('role_${code.toLowerCase()}_description');
}
