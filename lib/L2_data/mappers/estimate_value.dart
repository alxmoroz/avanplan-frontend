// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../../L1_domain/entities/estimate_value.dart';

extension EstimateValueMapper on EstimateValueGet {
  EstimateValue estimateValue(int wsId) => EstimateValue(
        id: id,
        value: value,
        title: title ?? '',
        description: description ?? '',
        workspaceId: wsId,
      );
}
