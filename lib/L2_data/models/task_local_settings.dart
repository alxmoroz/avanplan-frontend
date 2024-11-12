// Copyright (c) 2022. Alexandr Moroz

import 'package:hive/hive.dart';

import '../../L1_domain/entities/task_local_settings.dart';
import '../services/db.dart';
import 'base.dart';

part 'task_local_settings.g.dart';

@HiveType(typeId: HType.TASK_VIEW_FILTER)
class TaskViewFilterHO extends BaseModel<TaskViewFilter> {
  @HiveField(0)
  String type = TaskViewFilterType.ASSIGNEE.name;

  @HiveField(1)
  List values = [];

  @override
  TaskViewFilter toEntity() => TaskViewFilter(
        TaskViewFilterType.fromString(type),
        values,
      );

  @override
  Future<TaskViewFilterHO> update(TaskViewFilter entity) async {
    type = entity.type.name;
    values = entity.values;
    return this;
  }
}

@HiveType(typeId: HType.TASK_LOCAL_SETTINGS)
class TaskLocalSettingsHO extends BaseModel<TaskLocalSettings> {
  @HiveField(0, defaultValue: -1)
  int wsId = -1;

  @HiveField(1, defaultValue: -1)
  int taskId = -1;

  @HiveField(2)
  String viewMode = TaskViewMode.BOARD.name;

  @HiveField(3, defaultValue: <TaskViewFilterHO>[])
  List<TaskViewFilterHO> filters = [];

  @override
  TaskLocalSettings toEntity() => TaskLocalSettings(
        wsId: wsId,
        taskId: taskId,
        viewMode: TaskViewMode.fromString(viewMode),
        filters: filters.map((m) => m.toEntity()),
      );

  @override
  Future<TaskLocalSettingsHO> update(TaskLocalSettings entity) async {
    wsId = entity.wsId;
    taskId = entity.taskId;
    viewMode = entity.viewMode.name;

    filters.clear();
    final eFilters = entity.filters ?? [];
    for (final f in eFilters) {
      filters.add(await TaskViewFilterHO().update(f));
    }

    await save();
    return this;
  }
}
