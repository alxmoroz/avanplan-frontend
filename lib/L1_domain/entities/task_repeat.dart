// Copyright (c) 2024. Alexandr Moroz

import 'base_entity.dart';

enum TRPeriodType { DAILY, WEEKLY, MONTHLY }

class TaskRepeat extends WSBounded {
  TaskRepeat({
    super.id,
    super.wsId = -1,
    this.taskId = -1,
    this.periodType = "DAILY",
    this.periodLength = 1,
    this.daysList = '',
  });

  final int taskId;
  final String periodType;
  final int periodLength;
  final String daysList;

  static List<TRPeriodType> allPeriodTypes = TRPeriodType.values;

  bool get daily => periodType == TRPeriodType.DAILY.name;
  bool get weekly => periodType == TRPeriodType.WEEKLY.name;
  bool get monthly => periodType == TRPeriodType.MONTHLY.name;

  TaskRepeat copyWith({
    int? wsId,
    int? taskId,
    String? periodType,
    int? periodLength,
    String? daysList,
  }) =>
      TaskRepeat(
        wsId: wsId ?? this.wsId,
        taskId: taskId ?? this.taskId,
        periodType: periodType ?? this.periodType,
        periodLength: periodLength ?? this.periodLength,
        daysList: daysList ?? this.daysList,
      );
}
