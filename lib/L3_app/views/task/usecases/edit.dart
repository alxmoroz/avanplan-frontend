// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/entities/task_local_settings.dart';
import '../../../../L1_domain/entities_extensions/task_copy.dart';
import '../../../../L1_domain/entities_extensions/task_type.dart';
import '../../../components/button.dart';
import '../../../components/colors.dart';
import '../../../components/constants.dart';
import '../../../components/list_tile.dart';
import '../../../components/text.dart';
import '../../../extra/services.dart';
import '../../../navigation/router.dart';
import '../../../presenters/task_tree.dart';
import '../../../usecases/ws_actions.dart';
import '../controllers/task_controller.dart';
import '../usecases/tree.dart';
import '../widgets/create/create_task_dialog.dart';

extension TaskUC on Task {
  // TODO: постараться избавиться от этой логики
  // TODO: Нужна на случай попадания в аффектед таскс родителей (в т.ч. проекта) при редактировании после расчёта статистики
  // TODO: можно будет поправить вместе с задачей про рефакторинг StatsController (см. в техдолге задачу)
  // TODO: Также используется при обновлении инфы о родителях при загрузке taskNode. Хотя можно просто игнорировать в том случае.
  // вложенности
  Task refill(Task et) {
    if (isProject) {
      if (et.members.isEmpty) et.members = members;
      if (et.projectStatuses.isEmpty) et.projectStatuses = projectStatuses;
      if (et.projectModules.isEmpty) et.projectModules = projectModules;
    }

    if (filled) {
      if (et.notes.isEmpty) et.notes = notes;
      if (et.attachments.isEmpty) et.attachments = attachments;
      if (et.transactions.isEmpty) et.transactions = transactions;
      if (et.relations.isEmpty) et.relations = relations;

      et.repeat ??= repeat;
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
    tasksMainController.refreshUI();

    await load(function);

    task.loading = false;
    tasksMainController.refreshUI();
  }

  void _update(Task root, Iterable<Task> updatedTasks) {
    tasksMainController.upsertTasks([root, ...updatedTasks]);
    taskDescriptor = root;
    setupFields();
    reloadContentControllers();
  }

  Future reload({bool? closed}) async {
    final t = task;
    t.filled = false;

    await editWrapper(() async {
      setLoaderScreenLoading();
      final fullTree = settingsController.isProjectWithGroupsAndFilters;
      final taskNode = await taskUC.taskNode(taskDescriptor.wsId, taskDescriptor.id!, closed: closed, fullTree: fullTree);
      if (taskNode != null) {
        // удаление дерева подзадач
        // NB!: тут нужен новый массив, чтобы можно было удалить их
        for (final t in [...filteredSubtasks]) {
          tasksMainController.removeTask(t);
        }

        // новое дерево родителей и подзадач
        // сама задача / цель / проект
        final root = taskNode.root;
        root.filled = true;

        final updatedTasks = [...taskNode.subtasks, ...taskNode.parents];
        // мои задачи из проекта, если обновляем проект с целями
        if (root.isProjectWithGroups) {
          updatedTasks.addAll(await wsMyUC.myTasks(root.wsId, projectId: root.id!));
        }

        _update(root, updatedTasks);
      }
    });
  }

  Widget? loadClosedButton({bool board = false}) {
    final t = task;
    final hasNotLoadedTasks = t.closedSubtasksCount > t.closedSubtasks.length;
    return hasNotLoadedTasks
        ? board
            ? MTListTile(
                middle: BaseText.medium(loc.action_show_closed_title, color: mainColor, align: TextAlign.center),
                padding: const EdgeInsets.symmetric(horizontal: P2, vertical: P),
                loading: loading,
                bottomDivider: false,
                onTap: reload,
              )
            : MTButton.secondary(
                titleText: loc.action_show_closed_title,
                margin: const EdgeInsets.only(top: P3),
                loading: loading,
                onTap: reload,
              )
        : null;
  }

  Future<TaskController?> addSubtask({TType? type, int? statusId, bool noGo = false}) async {
    final parent = task;
    type ??= parent.isTask ? TType.CHECKLIST_ITEM : TType.TASK;
    statusId ??= ([TType.GOAL, TType.CHECKLIST_ITEM].contains(type) || parent.isInbox ? null : projectStatusesController.firstOpenedStatusId);
    final newTC = await createTask(
      parent.ws,
      type: type,
      parent: parent,
      statusId: statusId,
    );
    if (newTC != null) {
      // проект, в котором не было задач
      if (parent.isProject && !parent.hasSubtasks) {
        // добавили цель - переключаем на список, если задачу, то - на доску
        settingsController.setViewMode(type == TType.GOAL ? TaskViewMode.LIST.name : TaskViewMode.BOARD.name);
      }
      if (!noGo) router.goTask(newTC.taskDescriptor);
    }
    return newTC;
  }

  Future<Task?> save() async {
    Task? et;
    await editWrapper(() async {
      setLoaderScreenSaving();
      final t = task;
      if (await t.ws.checkBalance(loc.edit_action_title)) {
        final changes = await taskUC.save(t);
        if (changes != null) {
          tasksMainController.upsertTasks([changes.updated, ...changes.affected]);
          et = changes.updated;
        }
      }
    });
    return et;
  }

  Future move(Task dst) async => await editWrapper(() async {
        setLoaderScreenSaving();
        final src = task;
        // перенос внутри одного РП - просто меняем родителя
        // перенос между РП - новая задача в новом месте, старая удаляется
        final sameWS = dst.wsId == taskDescriptor.wsId;

        TasksChanges? changes;

        if (sameWS) {
          // статус в другом проекте
          int? dstProjectStatusId = src.projectStatusId;
          if (dst.project.id != src.project.id) {
            final psc = TaskController(taskIn: dst).projectStatusesController;
            psc.reload();
            dstProjectStatusId = psc.firstOpenedStatusId;
          }
          changes = await taskUC.save(src.copyWith(parentId: dst.id, projectStatusId: dstProjectStatusId));
        } else {
          changes = await taskUC.move(src, dst);
        }

        if (changes != null) {
          final root = changes.updated;
          root.filled = src.filled;
          // удаление задачи вместе с деревом подзадач
          if (!sameWS) tasksMainController.removeTask(src);
          _update(root, changes.affected);
          router.setTaskPathParameters(root);
        }
      });
}
