// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/task.dart';
import '../../../L1_domain/entities/workspace.dart';
import '../../../L1_domain/usecases/task_ext_state.dart';
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
  Task rootTask = Task(title: '', closed: false, parent: null, tasks: []);

  /// конкретная задача
  Task taskForId(int? id) => rootTask.allTasks.firstWhereOrNull((t) => t.id == id) ?? rootTask;
  Future showTask(BuildContext context, int? taskId) async {
    await Navigator.of(context).pushNamed(TaskView.routeName, arguments: taskId);
  }

  @action
  Future fetchData() async {
    try {
      workspaces = ObservableList.of(await myUC.getWorkspaces());
    } on DioError catch (e) {
      if (e.response?.statusCode == 403) {
        //TODO: могут быть сюрпризы, возможно, лучше сделать поп до корня
        await authController.logout();
        return;
      } else {
        print(e);
      }
    }

    workspaces.sort((w1, w2) => compareNatural(w1.title, w2.title));

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
    await accountController.fetchData();
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
    accountController.clearData();
  }

  Future updateAll() async {
    startLoading();
    await fetchData();
    // TODO: Подумать над фоновым обновлением или обновлением на бэке по расписанию. Иначе каждый запуск приложения — это будет вот это вот всё.
    // TODO: Можно эту логику на бэк отправить вообще вместе с настройкой частоты обновления для трекера. Чтобы вообще не запускать процесс импорта из клиента.
    if (await importController.updateLinkedTasks()) {
      await fetchData();
    }
    stopLoading();
  }
}
