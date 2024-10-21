// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/entities_extensions/task_copy.dart';
import '../../../../L1_domain/entities_extensions/task_type.dart';
import '../../../components/button.dart';
import '../../../components/colors.dart';
import '../../../components/constants.dart';
import '../../../components/list_tile.dart';
import '../../../components/text.dart';
import '../../../extra/services.dart';
import '../../../navigation/router.dart';
import '../../../presenters/project_module.dart';
import '../../../presenters/task_tree.dart';
import '../../../presenters/task_view.dart';
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
      if (et.members.isEmpty) et.members = members;
      if (et.projectStatuses.isEmpty) et.projectStatuses = projectStatuses;
      if (et.projectModules.isEmpty) et.projectModules = projectModules;
    }

    if (filled) {
      if (et.notes.isEmpty) et.notes = notes;
      if (et.attachments.isEmpty) et.attachments = attachments;
      if (et.transactions.isEmpty) et.transactions = transactions;

      et.repeat ??= repeat;
      et.taskSource ??= taskSource;

      et.filled = true;
    }

    // сохраняем настройки отображения доска / список
    // TODO: работает только до тех пор, пока не будет полная перезагрузка на главном экране
    et.viewSettings = viewSettings;

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

  Future reload({bool? closed}) async {
    task.filled = false;

    await editWrapper(() async {
      setLoaderScreenLoading();
      final filteredSubtasks = task.filteredSubtasks.toList();
      final taskNode = await taskUC.taskNode(taskDescriptor.wsId, taskDescriptor.id!, closed: closed, fullTree: task.isProjectWithGoalsAndFilters);
      if (taskNode != null) {
        // удаление дерева подзадач
        for (final t in filteredSubtasks) {
          tasksMainController.removeTask(t);
        }

        // новое дерево родителей и подзадач
        // сама задача / цель / проект
        final root = taskNode.root;
        root.filled = true;
        final newTasks = [root, ...taskNode.subtasks];
        // мои задачи из проекта, если обновляем проект с целями
        if (root.isProject && root.hmGoals) {
          newTasks.addAll(await wsMyUC.myTasks(root.wsId, projectId: root.id!));
        }
        tasksMainController.upsertTasks([...newTasks, ...taskNode.parents]);
        taskDescriptor = root;

        setupFields();
        reloadContentControllers();
      }
    });
  }

  Widget? loadClosedButton({bool board = false}) => task.closedSubtasksCount > task.closedSubtasks.length
      ? board
          ? MTListTile(
              middle: BaseText.medium(loc.action_show_closed_title, color: mainColor, align: TextAlign.center),
              padding: const EdgeInsets.symmetric(horizontal: P2, vertical: P),
              loading: loading,
              bottomDivider: false,
              onTap: () => reload(closed: true),
            )
          : MTButton.secondary(
              titleText: loc.action_show_closed_title,
              margin: const EdgeInsets.only(top: P3),
              loading: loading,
              onTap: () => reload(closed: true),
            )
      : null;

  Future<TaskController?> addSubtask({int? statusId, bool noGo = false}) async {
    final newTC = await createTask(
      task.ws,
      task,
      statusId: statusId ?? ((task.isProject && task.hmGoals) || task.isTask || task.isInbox ? null : projectStatusesController.firstOpenedStatusId),
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
          tasksMainController.upsertTasks([changes.updated, ...changes.affected]);
          et = changes.updated;
        }
      }
    });
    return et;
  }

  Future move(Task dst) async => await editWrapper(() async {
        setLoaderScreenSaving();
        // перенос внутри одного РП - просто меняем родителя
        // перенос между РП - новая задача в новом месте, старая удаляется
        final sameWS = dst.wsId == taskDescriptor.wsId;

        TasksChanges? changes;

        if (sameWS) {
          // статус в другом проекте
          int? dstProjectStatusId = task.projectStatusId;
          if (dst.project.id != task.project.id) {
            final psc = TaskController(taskIn: dst).projectStatusesController;
            psc.reload();
            dstProjectStatusId = psc.firstOpenedStatusId;
          }
          changes = await taskUC.save(task.copyWith(parentId: dst.id, projectStatusId: dstProjectStatusId));
        } else {
          changes = await taskUC.move(taskDescriptor, dst);
        }

        if (changes != null) {
          // changes.updated.filled = true;
          tasksMainController.upsertTasks([changes.updated, ...changes.affected]);
          if (!sameWS) tasksMainController.removeTask(task);
          taskDescriptor = changes.updated;
        }
      });
}
