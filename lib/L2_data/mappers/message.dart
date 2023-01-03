// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart' as api;

import '../../L1_domain/entities/message.dart';
import 'event.dart';
import 'user.dart';

extension EventMessageMapper on api.EventMessageGet {
  EventMessage get message => EventMessage(
        id: id,
        event: event.event,
        recipient: recipient.user,
        isRead: isRead ?? false,
      );
}
