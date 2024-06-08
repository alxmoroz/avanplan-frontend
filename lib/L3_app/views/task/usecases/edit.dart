// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/entities_extensions/task_tree.dart';
import '../../../components/button.dart';
import '../../../components/colors.dart';
import '../../../components/constants.dart';
import '../../../components/list_tile.dart';
import '../../../components/text.dart';
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
  // вложенности
  Task refill(Task et) {
    if (isProject) {
      if (et.members.isEmpty) {
        et.members = members;
      }
      if (et.projectStatuses.isEmpty) {
        et.projectStatuses = projectStatuses;
      }
      if (et.projectFeatureSets.isEmpty) {
        et.projectFeatureSets = projectFeatureSets;
      }
    }

    if (filled) {
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
    tasksMainController.refreshTasksUI();
  }

  Future reload({bool? closed}) async {
    task.filled = false;

    await editWrapper(() async {
      setLoaderScreenLoading();
      final taskNode = await taskUC.taskNode(taskDescriptor.wsId, taskDescriptor.id!, closed: closed);
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
        tasksMainController.setTasks([...newTasks, ...taskNode.parents]);
        taskDescriptor = root;

        setupFields();
        reloadContentControllers();
      }
    });
  }

  Widget? loadClosedButton({bool board = false}) => (task.closedSubtasksCount ?? 0) > task.closedSubtasks.length
      ? board
          ? MTListTile(
              middle: BaseText.medium(loc.show_closed_action_title, color: mainColor, align: TextAlign.center),
              padding: const EdgeInsets.symmetric(horizontal: P2, vertical: P),
              loading: loading,
              bottomDivider: false,
              onTap: reload,
            )
          : MTButton.secondary(
              titleText: loc.show_closed_action_title,
              margin: const EdgeInsets.only(top: P3),
              loading: loading,
              onTap: reload,
            )
      : null;

  Future<TaskController?> addSubtask({int? statusId, bool noGo = false}) async {
    final newTC = await createTask(
      task.ws,
      task,
      statusId: statusId ?? ((task.isProject && task.hfsGoals) || task.isTask || task.isInbox ? null : projectStatusesController.firstOpenedStatusId),
    );
    if (newTC != null && !noGo) router.goTaskView(newTC.taskDescriptor);
    return newTC;
  }

  Future<Task?> save() async {
    Task? et;
    await editWrapper(() async {
      setLoaderScreenSaving();
      if (await task.ws.checkBalance(loc.edit_action_title)) {
        final changes = await taskUC.save(task);
        if (changes != null) {
          tasksMainController.setTasks([changes.updated, ...changes.affected]);
          et = changes.updated;
        }
      }
    });
    return et;
  }

  Future move(Task dst) async => await editWrapper(() async {
        setLoaderScreenSaving();
        // TODO: проверяем баланс в РП назначения. Хотя, в исходном тоже надо бы проверять...
        if (await dst.ws.checkBalance(loc.task_transfer_export_action_title)) {
          // перенос внутри одного РП - просто меняем родителя
          // перенос между РП - новая задача в новом месте, старая удаляется

          final sameWS = dst.wsId == taskDescriptor.wsId;

          TasksChanges? changes;

          if (sameWS) {
            // статус в другом проекте
            final oldStatusId = task.projectStatusId;
            if (dst.project.id != task.project.id) {
              final psc = TaskController(taskIn: dst).projectStatusesController;
              psc.reload();
              task.projectStatusId = psc.firstOpenedStatusId;
            }
            // родитель
            final oldParentId = task.parentId;
            task.parentId = dst.id;
            changes = await taskUC.save(task);
            // ошибка
            if (changes == null) {
              task.parentId = oldParentId;
              task.projectStatusId = oldStatusId;
            }
          } else {
            changes = await taskUC.move(taskDescriptor, dst);
          }

          if (changes != null) {
            // changes.updated.filled = true;
            tasksMainController.setTasks([changes.updated, ...changes.affected]);
            if (!sameWS) tasksMainController.removeTask(task);
            taskDescriptor = changes.updated;
          }
        }
      });
}
