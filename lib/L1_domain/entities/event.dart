// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';
import 'event_type.dart';

class Event extends RPersistable {
  Event({
    required super.id,
    required this.description,
    required this.type,
    required this.createdOn,
    required this.taskId,
  });

  final String? description;
  final EventType type;
  final DateTime createdOn;
  final int? taskId;

  bool get hasDescription => description != null && description!.trim().isNotEmpty;
}
