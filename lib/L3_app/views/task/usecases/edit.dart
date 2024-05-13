// Copyright (c) 2024. Alexandr Moroz

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/entities_extensions/task_tree.dart';
import '../../../extra/router.dart';
import '../../../extra/services.dart';
import '../../../usecases/task_feature_sets.dart';
import '../../../usecases/task_tree.dart';
import '../../../usecases/ws_actions.dart';
import '../controllers/task_controller.dart';
import '../widgets/create/create_task_dialog.dart';

extension TaskUC on Task {
  // TODO: постараться избавиться от этой логики
  // TODO: Нужна на случай попадания в аффектед таскс родителей (в т.ч. проекта) при редактировании после расчёта статистики
  // TODO: можно будет поправить вместе с задачей про рефакторинг StatsController (см. в техдолге задачу)
  // TODO: Также используется при обновлении инфы о родителях при загрузке taskNode. Хотя можно просто игнорировать в том случае.
  Task refill(Task et) {
    if (filled) {
      // вложенности
      if (et.members.isEmpty) {
        et.members = members;
      }
      if (et.projectStatuses.isEmpty) {
        et.projectStatuses = projectStatuses;
      }
      if (et.projectFeatureSets.isEmpty) {
        et.projectFeatureSets = projectFeatureSets;
      }
      if (et.notes.isEmpty) {
        et.notes = notes;
      }
      if (et.attachments.isEmpty) {
        et.attachments = attachments;
      }

      et.taskSource ??= taskSource;

      et.filled = true;
    }

    return et;
  }
}

extension TaskEditUC on TaskController {
  Future<bool> saveField(TaskFCode code) async {
    updateField(code.index, loading: true);
    final saved = await save() != null;
    updateField(code.index, loading: false);
    return saved;
  }

  Future editWrapper(Function() function) async {
    task.loading = true;
    tasksMainController.refreshTasksUI();

    await load(function);

    task.loading = false;
    tasksMainController.refreshTasksUI(sort: true);
  }

  Future reload() async {
    // TODO: лишнее? - это чтобы сработал флаг contentLoading
    task.filled = false;

    await editWrapper(() async {
      setLoaderScreenLoading();
      final taskNode = await taskUC.taskNode(taskDescriptor.wsId, taskDescriptor.id!);
      if (taskNode != null) {
        // удаление дерева подзадач
        task.subtasks.toList().forEach((t) => tasksMainController.removeTask(t));

        // новое дерево родителей и подзадач
        // сама задача / цель / проект
        final root = taskNode.root;
        root.filled = true;
        final newTasks = [root, ...taskNode.subtasks];
        // мои задачи из проекта, если обновляем проект с целями
        if (root.isProject && root.hfsGoals) {
          newTasks.addAll(await wsUC.getMyTasks(root.wsId, projectId: root.id!));
        }
        tasksMainController.setTasks(taskNode.parents);
        tasksMainController.setTasks(newTasks);

        taskDescriptor = root;

        setupFields();
        reloadContentControllers();
      }
    });
  }

  Future<Task?> addSubtask({int? statusId, bool noGo = false}) async {
    final newTask = await createTask(
      task.ws,
      task,
      statusId: statusId ?? (task.isProject || task.isTask || task.isInbox ? null : projectStatusesController.firstOpenedStatusId),
    );
    if (newTask != null && !noGo) router.goTaskView(newTask);
    return newTask;
  }

  Future<Task?> save() async {
    Task? et;
    await editWrapper(() async {
      setLoaderScreenSaving();
      if (await task.ws.checkBalance(loc.edit_action_title)) {
        final changes = await taskUC.save(task);
        if (changes != null) {
          tasksMainController.setTasks(changes.affected);
          tasksMainController.setTasks([changes.updated]);
          et = changes.updated;
        }
      }
    });
    return et;
  }

  // TODO: нужен переход в новое место в конце
  Future move(Task destination) async => await editWrapper(() async {
        if (await destination.ws.checkBalance(loc.task_transfer_export_action_title)) {
          final changes = await taskUC.move(taskDescriptor, destination);
          if (changes != null) {
            changes.updated.filled = true;
            tasksMainController.setTasks(changes.affected);
            tasksMainController.setTasks([changes.updated]);
            tasksMainController.removeTask(task);
          }
        }
      });
}
