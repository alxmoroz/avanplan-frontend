// Copyright (c) 2024. Alexandr Moroz

import 'package:collection/collection.dart';

import 'base_entity.dart';

enum TaskViewMode {
  LIST,
  BOARD;

  static TaskViewMode fromString(String name) => TaskViewMode.values.firstWhereOrNull((s) => s.name == name) ?? TaskViewMode.BOARD;
}

enum TaskViewFilterType {
  ASSIGNEE;

  static TaskViewFilterType fromString(String name) =>
      TaskViewFilterType.values.firstWhereOrNull((s) => s.name == name) ?? TaskViewFilterType.ASSIGNEE;
}

class TaskViewFilter extends LocalPersistable {
  TaskViewFilter(this.type, this.values);
  final TaskViewFilterType type;
  final List values;

  bool get isAssignee => type == TaskViewFilterType.ASSIGNEE;
  bool get isEmpty => values.isEmpty;
  bool get isNotEmpty => values.isNotEmpty;
}

class TaskLocalSettings extends LocalPersistable {
  TaskLocalSettings({
    required this.wsId,
    required this.taskId,
    this.viewMode = TaskViewMode.BOARD,
    this.filters,
  });
  final int wsId;
  int taskId;
  TaskViewMode viewMode;
  Iterable<TaskViewFilter>? filters;

  TaskLocalSettings copyWith({TaskViewMode? viewMode, Iterable<TaskViewFilter>? filters}) => TaskLocalSettings(
        wsId: wsId,
        taskId: taskId,
        viewMode: viewMode ?? this.viewMode,
        filters: filters ?? this.filters,
      );
}
