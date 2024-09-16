// Copyright (c) 2024. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities/task_view_settings.dart';
import '../../../../../L1_domain/entities/ws_member.dart';
import '../../../../../L1_domain/entities_extensions/task_members.dart';
import 'view_settings_controller.dart';

part 'assignee_filter_controller.g.dart';

class TaskViewAssigneeFilterController extends _Base with _$TaskViewAssigneeFilterController {
  TaskViewAssigneeFilterController(TaskViewSettingsController vsc) {
    _vsController = vsc;
    activeMembers = task.activeMembers;
    _reload();
  }
}

abstract class _Base with Store {
  late final TaskViewSettingsController _vsController;
  late final List<WSMember> activeMembers;

  Task get task => _vsController.task;

  @observable
  ObservableList<bool> checks = ObservableList();

  @computed
  bool get checkedAll => !checks.contains(false);

  @action
  _reload() {
    final filteredAssigneeIds = task.viewSettings.assigneeFilter?.values ?? [];
    checks = ObservableList.of([for (var m in activeMembers) filteredAssigneeIds.contains(m.id)]);
  }

  @action
  toggleAll(bool? value) => checks = ObservableList.of([for (var _ in activeMembers) value == true]);

  @action
  check(int index, bool? selected) => checks[index] = selected == true;

  save() {
    final filteredAssigneeIds = [];
    for (int index = 0; index < checks.length; index++) {
      if (checks[index]) {
        filteredAssigneeIds.add(activeMembers[index].id);
      }
    }

    _vsController.setFilter(TaskViewFilter(TaskViewFilterType.ASSIGNEE, filteredAssigneeIds));
  }
}
