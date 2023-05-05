// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart' as api;

import '../../L1_domain/entities/user_activity.dart';

extension UserActivityMapper on api.UActivityGet {
  UActivity get activity => UActivity(
        id: id,
        wsId: wsId,
        code: code,
        platform: platform,
        createdOn: createdOn.toLocal(),
      );
}
