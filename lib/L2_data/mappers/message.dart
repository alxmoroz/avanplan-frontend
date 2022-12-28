// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart' as api;

import '../../L1_domain/entities/message.dart';
import 'event.dart';
import 'user.dart';

extension MessageMapper on api.MessageGet {
  Message get message => Message(
        id: id,
        event: event.event,
        recipient: recipient.user,
        readDate: readDate?.toLocal(),
      );
}
