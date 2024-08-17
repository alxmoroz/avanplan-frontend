// Copyright (c) 2024. Alexandr Moroz

import 'base_entity.dart';

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
}
