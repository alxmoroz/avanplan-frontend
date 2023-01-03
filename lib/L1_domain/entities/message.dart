// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';
import 'event.dart';
import 'user.dart';

class EventMessage extends RPersistable {
  EventMessage({
    required super.id,
    required this.event,
    required this.recipient,
    required this.isRead,
  });

  final Event event;
  final User recipient;

  bool isRead;
}
