// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';
import 'event.dart';
import 'user.dart';

class Message extends RPersistable {
  Message({
    required super.id,
    required this.event,
    required this.recipient,
    required this.readDate,
  });

  final Event event;
  final User recipient;

  DateTime? readDate;
  bool get isRead => readDate != null;
}
