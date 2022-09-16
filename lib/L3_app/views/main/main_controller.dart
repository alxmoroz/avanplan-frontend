// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/task.dart';
import '../../../L1_domain/entities/task_ext_state.dart';
import '../../../L1_domain/entities/workspace.dart';
import '../../extra/services.dart';
import '../_base/base_controller.dart';
import '../task/task_view.dart';

part 'main_controller.g.dart';

class MainController extends _MainControllerBase with _$MainController {}

abstract class _MainControllerBase extends BaseController with Store {
  /// рабочие пространства
  @observable
  ObservableList<Workspace> workspaces = ObservableList();

  /// рутовый объект
  @observable
  Task rootTask = Task(
    title: '',
    parent: null,
    tasks: [],
    description: '',
    closed: false,
    createdOn: DateTime.now(),
    updatedOn: DateTime.now(),
  );

  /// конкретная задача
  Task taskForId(int? id) => rootTask.allTasks.firstWhereOrNull((t) => t.id == id) ?? rootTask;
  Future showTask(BuildContext context, int? taskId) async {
    await Navigator.of(context).pushNamed(TaskView.routeName, arguments: taskId);
  }

  @action
  Future fetchData() async {
    //TODO: сделать computed для всех зависимых данных? pro: прозрачная логика загрузки cons: увеличение связанности. В любом случае большой вопрос с редактированием словарей.
    // Например, трекеров... Будет похожая заморочка, как в дереве задач (зато есть опыт уже)

    try {
      workspaces = ObservableList.of(await workspacesUC.getAll());
    } catch (e) {
      if (e is DioError && e.response?.statusCode == 403) {
        await loginController.logout();
        return;
      } else {
        print(e);
      }
    }

    workspaces.sort((ws1, ws2) => ws1.title.compareTo(ws2.title));

    final tasks = <Task>[];
    for (Workspace ws in workspaces) {
      if (ws.id != null) {
        tasks.addAll(await tasksUC.getRoots(ws.id!));
      }
    }
    tasks.forEach((t) => t.parent = rootTask);
    rootTask.tasks = tasks;
    touchRootTask();
    // TODO: чтобы сохранять положение в навигации внутри приложения, нужно синхронизировать id текущей выбранной задачи на сервер в профиль пользователя

    await sourceController.fetchData();
    await settingsController.fetchData();
    await userController.fetchData();
  }

  @action
  void touchRootTask() => rootTask = rootTask.copy();

  @action
  void clearData() {
    workspaces.clear();
    rootTask.tasks = [];

    sourceController.clearData();
    importController.clearData();
    settingsController.clearData();
    userController.clearData();
  }

  Future updateAll() async {
    startLoading();
    await fetchData();
    // TODO: Подумать над фоновым обновлением или обновлением на бэке по расписанию. Иначе каждый запуск прилоежния — это будет вот это вст всё.
    // TODO: Можно эту логику на бэк отправить вообще вместе с настройкой частоты обновления для трекера. Чтобы вообще не запускать процесс импорта из клиента.
    if (await importController.updateLinkedTasks()) {
      await fetchData();
    }
    stopLoading();
  }
}
