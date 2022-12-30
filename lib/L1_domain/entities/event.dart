// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';
import 'event_type.dart';

class Event extends Titleable {
  Event({
    required super.id,
    required super.title,
    required this.description,
    required this.type,
    required this.createdOn,
  });

  final String? description;
  final EventType? type;
  final DateTime createdOn;

  bool get hasDescription => description != null && description!.trim().isNotEmpty;
}
