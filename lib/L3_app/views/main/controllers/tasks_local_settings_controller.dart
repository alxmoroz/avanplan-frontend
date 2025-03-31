// Copyright (c) 2024. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:mobx/mobx.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/entities/task_local_settings.dart';
import '../../../../L1_domain/entities_extensions/task_type.dart';
import '../../../presenters/task_settings.dart';
import '../../app/services.dart';

part 'tasks_local_settings_controller.g.dart';

class TasksLocalSettingsController extends _Base with _$TasksLocalSettingsController {
  Future<TasksLocalSettingsController> init() async {
    _allSettings = ObservableList.of(await tasksLocalSettingsUC.getAll());
    return this;
  }

  TaskLocalSettings? _taskSettings(TaskDescriptor td) {
    final wsId = td.wsId;
    final taskId = td.id!;
    return _tsMap[wsId]?[taskId];
  }

  TaskLocalSettings taskSettings(Task t) =>
      _taskSettings(t) ??
      TaskLocalSettings(
        wsId: t.wsId,
        taskId: t.id!,
        viewMode: (t.isProject || t.isInbox) ? t.defaultProjectViewMode : TaskViewMode.BOARD,
      );
}

abstract class _Base with Store {
  @observable
  ObservableList<TaskLocalSettings> _allSettings = ObservableList();

  @computed
  Map<int, Map<int, TaskLocalSettings>> get _tsMap =>
      groupBy<TaskLocalSettings, int>(_allSettings, (ts) => ts.wsId).map((wsId, tss) => MapEntry(wsId, {for (final ts in tss) ts.taskId: ts}));

  @action
  Future updateTS(TaskLocalSettings ets) async {
    await tasksLocalSettingsUC.update(ets);
    final index = _allSettings.indexWhere((ts) => ts.wsId == ets.wsId && ts.taskId == ets.taskId);
    if (index > -1) {
      _allSettings[index] = ets;
    } else {
      _allSettings.add(ets);
    }
  }
}
