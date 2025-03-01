// Copyright (c) 2022. Alexandr Moroz

import 'package:avanplan_api/avanplan_api.dart';

import '../../L1_domain/entities/estimate_value.dart';

extension EstimateValueMapper on EstimateValueGet {
  EstimateValue estimateValue(int wsId) => EstimateValue(
        id: id,
        value: value,
        title: title ?? '',
        description: description ?? '',
        wsId: wsId,
      );
}
