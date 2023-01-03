// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart' as api;

import '../../L1_domain/entities/event.dart';
import 'event_type.dart';

extension EventMapper on api.EventGet {
  Event get event => Event(
        id: id,
        type: type.type,
        createdOn: createdOn.toLocal(),
        objectId: objectId,
      );
}
