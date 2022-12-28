// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart' as api;

import '../../L1_domain/entities/event_type.dart';

extension EventTypeMapper on api.EventTypeGet {
  EventType get type => EventType(
        id: id,
        title: title,
      );
}
