// Copyright (c) 2024. Alexandr Moroz

import 'base_entity.dart';

enum TRPeriodType { DAILY, WEEKLY, MONTHLY }

class TaskRepeat extends WSBounded {
  TaskRepeat({
    super.id,
    required super.wsId,
    required this.taskId,
    required this.periodType,
    required this.periodLength,
    required this.daysList,
  });

  final int taskId;

  String periodType;
  int periodLength;
  String daysList;

  bool get daily => periodType == TRPeriodType.DAILY.name;
  bool get weekly => periodType == TRPeriodType.WEEKLY.name;
  bool get monthly => periodType == TRPeriodType.MONTHLY.name;

  TaskRepeat copyWith({int? wsId, int? taskId, String? periodType, int? periodLength, String? daysList}) => TaskRepeat(
        wsId: wsId ?? this.wsId,
        taskId: taskId ?? this.taskId,
        periodType: periodType ?? this.periodType,
        periodLength: periodLength ?? this.periodLength,
        daysList: daysList ?? this.daysList,
      );
}
