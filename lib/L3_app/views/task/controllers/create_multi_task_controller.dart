// Copyright (c) 2023. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../usecases/task_edit.dart';
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
  ObservableList<TaskController> taskControllers = ObservableList();

  @action
  void _setControllers(Iterable<Task> tasks) => taskControllers = ObservableList.of(tasks.map((t) => TaskController(t)));

  @action
  void refresh() => taskControllers = ObservableList.of(taskControllers);

  @action
  Future addTask() async {
    final newTask = await parent.ws.createTask(parent);
    if (newTask != null) {
      final tc = TaskController(newTask, isNew: true);
      taskControllers.add(tc);
      setFocus(true, tc);
    }
  }

  void setFocus(bool f, TaskController tc) {
    final fn = tc.focusNode(TaskFCode.title.index);
    if (fn != null) {
      final hf = fn.hasFocus == true;
      if (f && !hf) {
        fn.requestFocus();
      } else if (hf) {
        fn.unfocus();
      }
    }
  }

  @action
  Future<bool> deleteTask(TaskController tc) async {
    refresh();
    await tc.task.delete();
    tc.dispose();
    taskControllers.remove(tc);
    return false;
  }

  Future editTitle(TaskController tc, String str) async {
    await tc.titleController.editTitle(str, doneCb: refresh);
  }

  void dispose() {
    taskControllers.forEach((tc) => tc.dispose());
  }
}
