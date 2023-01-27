// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';

class Event extends RPersistable {
  Event({
    required super.id,
    required this.type,
    required this.createdOn,
    required this.objectId,
  });

  final String type;
  final DateTime createdOn;
  final int? objectId;
}
