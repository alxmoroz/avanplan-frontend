// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../../L1_domain/entities/goals/remote_tracker.dart';
import 'remote_tracker_type.dart';

extension TrackerMapper on RemoteTrackerSchemaGet {
  RemoteTracker get tracker => RemoteTracker(
        id: id,
        type: type.type,
        url: url,
        loginKey: loginKey,
        description: description,
      );
}
