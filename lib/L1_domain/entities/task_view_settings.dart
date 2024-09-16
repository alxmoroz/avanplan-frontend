// Copyright (c) 2024. Alexandr Moroz

import 'package:collection/collection.dart';

enum TaskViewMode { LIST, BOARD }

enum TaskViewFilterType { ASSIGNEE }

class TaskViewFilter {
  TaskViewFilter(this.type, this.values);
  final TaskViewFilterType type;
  final List values;

  bool get isAssignee => type == TaskViewFilterType.ASSIGNEE;
  bool get isEmpty => values.isEmpty;
}

class TaskViewSettings {
  TaskViewSettings({this.viewMode = TaskViewMode.BOARD, this.filters});
  final TaskViewMode viewMode;
  final Iterable<TaskViewFilter>? filters;

  bool get showBoard => viewMode == TaskViewMode.BOARD;
  bool get hasFilters => filters?.isNotEmpty == true;

  TaskViewFilter? get assigneeFilter => filters?.firstWhereOrNull((f) => f.isAssignee);
}
