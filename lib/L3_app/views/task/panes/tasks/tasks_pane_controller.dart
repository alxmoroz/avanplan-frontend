// Copyright (c) 2023. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../presenters/task_filter_presenter.dart';

part 'tasks_pane_controller.g.dart';

class TasksPaneController extends _TasksPaneControllerBase with _$TasksPaneController {
  TasksPaneController(Task _task) {
    task = _task;
  }
}

abstract class _TasksPaneControllerBase with Store {
  late final Task task;

  /// фильтры и сортировка
  @observable
  bool? _showGroupTitles;

  @computed
  bool get showGroupTitles => _showGroupTitles ?? task.subtaskGroups.length > 1 && task.tasks.length > 4;

  @observable
  bool showBoard = false;

  @action
  void toggleMode() => showBoard = !showBoard;
}
