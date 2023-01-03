// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart' as api;

import '../../L1_domain/entities/estimate.dart';

extension EstimateMapper on api.EstimateGet {
  Estimate get estimate => Estimate(
        id: id,
        value: value,
        workspaceId: workspaceId,
      );
}
