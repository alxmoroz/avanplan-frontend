// Copyright (c) 2023. Alexandr Moroz

import 'package:collection/collection.dart';

import '../entities/estimate_value.dart';
import '../entities/source.dart';
import '../entities/source_type.dart';
import '../entities/workspace.dart';

extension WSExtension on Workspace {
  Source? sourceForId(int? id) => sources.firstWhereOrNull((s) => s.id == id);
  Source? sourceForType(SourceType? type) => sources.firstWhereOrNull((s) => s.typeCode == type?.code);

  num get welcomeGiftAmount => mainAccount.incomingOperations.firstWhereOrNull((op) => op.basis == 'WELCOME_GIFT')?.amount ?? 0;

  EstimateValue? estimateValueForId(int? id) => estimateValues.firstWhereOrNull((ev) => ev.id == id);
  EstimateValue? estimateValueForValue(int? value) => estimateValues.firstWhereOrNull((ev) => ev.value == value);
}
