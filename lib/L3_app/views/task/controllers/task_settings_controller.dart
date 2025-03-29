// Copyright (c) 2024. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:mobx/mobx.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/entities/task_local_settings.dart';
import '../../../../L1_domain/entities/ws_member.dart';
import '../../../../L1_domain/entities_extensions/task_members.dart';
import '../../../../L1_domain/entities_extensions/task_type.dart';
import '../../../presenters/task_tree.dart';
import '../../app/services.dart';
import '../usecases/edit.dart';
import 'task_controller.dart';

part 'task_settings_controller.g.dart';

class TaskSettingsController extends _Base with _$TaskSettingsController {
  TaskSettingsController(TaskController tc) {
    _tc = tc;
  }

  void setAssigneeFilter(int assigneeId) => setFilter(TaskViewFilter(TaskViewFilterType.ASSIGNEE, [assigneeId]));

  void resetAssigneesFilter() {
    if (hasFilters) {
      final filters = [...this.filters!];
      filters.removeWhere((f) => f.type == TaskViewFilterType.ASSIGNEE);
      _saveSettings(filters: filters);
    }
  }

  void saveAssigneeFilter() {
    final filteredAssigneeIds = [];
    for (int index = 0; index < membersChecks.length; index++) {
      if (membersChecks[index]) {
        filteredAssigneeIds.add(activeMembers[index].id);
      }
    }

    setFilter(TaskViewFilter(TaskViewFilterType.ASSIGNEE, filteredAssigneeIds));
  }

  void setFilter(TaskViewFilter f) {
    bool hasChanges = false;
    final List<TaskViewFilter> filters = List.of(this.filters ?? []);
    if (f.isEmpty) {
      filters.removeWhere((f) => f.type == f.type);
    } else {
      final index = filters.indexWhere((f) => f.type == f.type);
      if (index > -1) {
        final oldFilter = filters[index];
        hasChanges = oldFilter.values != f.values;
        if (hasChanges) filters[index] = f;
      } else {
        hasChanges = true;
        filters.add(f);
      }
    }
    _saveSettings(filters: filters);

    // обновляем проект с целями при включении фильтрации
    if (hasChanges && isProjectWithGroupsAndFilters) _tc.reload(closed: false);
  }

  void setViewMode(String? name) {
    _saveSettings(viewMode: TaskViewMode.fromString(name));
  }
}

abstract class _Base with Store {
  late final TaskController _tc;

  Task get task => _tc.task;
  List<WSMember> get activeMembers => task.activeMembers;

  @observable
  TaskLocalSettings settings = TaskLocalSettings(wsId: -1, taskId: -1);

  @computed
  TaskViewMode get viewMode => task.isGoal ? settings.subtasksViewMode : settings.viewMode;

  @computed
  bool get hasFilters => settings.filters?.isNotEmpty == true;

  @computed
  TaskViewFilter? get assigneeFilter => filters?.firstWhereOrNull((f) => f.isAssignee);

  @computed
  Iterable<TaskViewFilter>? get filters => settings.filters;

  @computed
  Iterable<WSMember> get _filteredAssignees => activeMembers.where((m) => _filteredAssigneeIds.contains(m.id));

  @computed
  List<int> get _filteredAssigneeIds => assigneeFilter?.values.map((v) => v as int).toList() ?? [];

  @computed
  bool get hasFilteredAssignees => _filteredAssignees.isNotEmpty;

  @computed
  String get filteredAssigneesStr => _filteredAssignees.map((m) => '$m').join(', ');

  @computed
  bool get isProjectWithGroupsAndFilters => task.isProjectWithGroups && hasFilteredAssignees;

  void _reloadChecks() {
    membersChecks = ObservableList.of([for (var m in activeMembers) _filteredAssigneeIds.contains(m.id)]);
  }

  @action
  void reload() {
    // зачитать из проекта, если там есть настройки и если это цель
    final t = task;
    settings = tasksLocalSettingsController.taskSettings(t.isGoal ? t.project : t);
    _reloadChecks();
  }

  @action
  Future _saveSettings({TaskViewMode? viewMode, List<TaskViewFilter>? filters}) async {
    final t = task;
    // если мы находимся в цели, то нужно перезаписать настройки вида в проекте для всех целей
    if (t.isGoal) {
      settings = settings.copyWith(subtasksViewMode: viewMode, filters: filters);
    } else {
      settings = settings.copyWith(viewMode: viewMode, filters: filters);
    }

    _reloadChecks();
    await tasksLocalSettingsController.updateTS(settings);
    tasksMainController.refreshUI();
  }

  @observable
  ObservableList<bool> membersChecks = ObservableList();

  @action
  void checkMember(int index, bool? selected) => membersChecks[index] = selected == true;
}
