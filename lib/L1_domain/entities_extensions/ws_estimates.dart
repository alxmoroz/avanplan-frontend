// Copyright (c) 2023. Alexandr Moroz

import 'package:collection/collection.dart';

import '../entities/estimate_value.dart';
import '../entities/workspace.dart';

extension WSEstimates on Workspace {
  EstimateValue? estimateValueForId(int? id) => estimateValues.firstWhereOrNull((ev) => ev.id == id);
  EstimateValue? estimateValueForValue(num? value) => estimateValues.firstWhereOrNull((ev) => ev.value == value);
}
