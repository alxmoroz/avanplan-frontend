// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../../L1_domain/entities/goals/remote_tracker.dart';

extension TrackerTypeMapper on RemoteTrackerTypeSchemaGet {
  RemoteTrackerType get type => RemoteTrackerType(
        id: id,
        title: title,
      );
}
