// Copyright (c) 2023. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../usecases/task_tree.dart';
import '../../../usecases/ws_tasks.dart';
import 'task_controller.dart';

part 'create_multi_task_controller.g.dart';

class CreateMultiTaskController extends _CreateMultiTaskControllerBase with _$CreateMultiTaskController {
  CreateMultiTaskController(TaskController _parentTaskController) {
    parentTaskController = _parentTaskController;
    _setControllers(_parentTaskController.task.subtasks);
  }
}

abstract class _CreateMultiTaskControllerBase with Store {
  late final TaskController parentTaskController;

  Task get parent => parentTaskController.task;

  @observable
  ObservableList<TaskController> _taskControllers = ObservableList();

  @action
  void _setControllers(Iterable<Task> tasks) => _taskControllers = ObservableList.of(tasks.map((t) => TaskController(t)));

  @computed
  List<TaskController> get sortedControllers => _taskControllers; //.sorted((c1, c2) => sortByDateAsc(c1.task, c2.task));

  @action
  Future addTask() async {
    final newTask = await parent.ws.createTask(parent);
    if (newTask != null) {
      _taskControllers.add(TaskController(newTask, isNew: true));
    }
  }
}
