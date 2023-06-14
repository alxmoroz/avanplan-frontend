// Copyright (c) 2023. Alexandr Moroz

import 'package:collection/collection.dart';

import '../entities/estimate_value.dart';
import '../entities/source.dart';
import '../entities/status.dart';
import '../entities/workspace.dart';

extension WSExtension on Workspace {
  Source? sourceForId(int? id) => sources.firstWhereOrNull((s) => s.id == id);
  Source? sourceForType(String? type) => sources.firstWhereOrNull((s) => s.type == type);

  num get welcomeGiftAmount => mainAccount.incomingOperations.firstWhereOrNull((op) => op.basis == 'WELCOME_GIFT')?.amount ?? 0;

  Iterable<int> get _closedStatusIds => statuses.where((s) => s.closed == true).map((s) => s.id!);
  int? get firstClosedStatusId => _closedStatusIds.firstOrNull;

  Iterable<int> get _openedStatusIds => statuses.where((s) => s.closed == false).map((s) => s.id!);
  int? get firstOpenedStatusId => _openedStatusIds.firstOrNull;

  Status? statusForId(int? id) => statuses.firstWhereOrNull((s) => s.id == id);
  EstimateValue? estimateValueForId(int? id) => estimateValues.firstWhereOrNull((ev) => ev.id == id);
  EstimateValue? estimateValueForValue(int? value) => estimateValues.firstWhereOrNull((ev) => ev.value == value);
}
