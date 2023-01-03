// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';
import 'event_type.dart';

class Event extends RPersistable {
  Event({
    required super.id,
    required this.type,
    required this.createdOn,
    required this.objectId,
  });

  final EventType type;
  final DateTime createdOn;
  final int? objectId;
}
