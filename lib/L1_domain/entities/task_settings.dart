// Copyright (c) 2025. Alexandr Moroz

import 'package:collection/collection.dart';

import 'base_entity.dart';

enum TSCode {
  VIEW_MODE;

  static TSCode fromString(String name) => values.firstWhereOrNull((v) => v.name.toLowerCase() == name.toLowerCase()) ?? VIEW_MODE;
}

class TaskSettings extends RPersistable {
  TaskSettings({
    super.id,
    required this.taskId,
    required this.code,
    required this.value,
  });

  final int taskId;
  final TSCode code;
  final String value;
}
