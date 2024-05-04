// Copyright (c) 2023. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../usecases/task_edit.dart';
import '../../../usecases/task_tree.dart';
import '../../../usecases/ws_tasks.dart';
import 'task_controller.dart';

part 'subtasks_controller.g.dart';

class SubtasksController extends _SubtasksControllerBase with _$SubtasksController {
  SubtasksController(TaskController parentTaskController) {
    _parentTaskController = parentTaskController;
    reload();
  }
}

abstract class _SubtasksControllerBase with Store {
  late final TaskController _parentTaskController;

  Task get parent => _parentTaskController.task;

  @observable
  ObservableList<TaskController> taskControllers = ObservableList();

  @action
  void reload() => taskControllers = ObservableList.of(parent.subtasks.map((t) => TaskController(t)));

  @action
  Future addTask() async {
    final newTask = await parent.ws.createTask(parent, statusId: _parentTaskController.projectStatusesController.firstOpenedStatusId);
    if (newTask != null) {
      final tc = TaskController(newTask);
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
    await tc.task.delete();
    tc.dispose();
    taskControllers.remove(tc);
    return false;
  }

  Future editTitle(TaskController tc, String str) async {
    await tc.titleController.editTitle(str);
  }

  void dispose() {
    for (TaskController tc in taskControllers) {
      tc.dispose();
    }
    taskControllers.clear();
  }
}
