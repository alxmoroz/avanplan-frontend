// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../../L1_domain/entities/estimate_unit.dart';

extension EstimateUnitMapper on EstimateUnitGet {
  EstimateUnit unit(int wsId) => EstimateUnit(
        id: id,
        abbreviation: abbreviation,
        title: title ?? '',
        description: description ?? '',
        wsId: wsId,
      );
}
