// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';

class MTNotification extends Titleable {
  MTNotification({
    required super.id,
    required super.title,
    required super.description,
    required this.scheduledDate,
    required this.isRead,
    required this.url,
    required this.messageId,
  });

  DateTime scheduledDate;
  bool isRead;
  String? url;
  int messageId;
}
