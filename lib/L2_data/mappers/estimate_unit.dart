// Copyright (c) 2022. Alexandr Moroz

import 'package:avanplan_api/avanplan_api.dart';

import '../../L1_domain/entities/estimate_unit.dart';

extension EstimateUnitMapper on EstimateUnitGet {
  EstimateUnit get unit => EstimateUnit(
        id: id,
        code: code,
        title: title ?? '',
        description: description ?? '',
      );
}
