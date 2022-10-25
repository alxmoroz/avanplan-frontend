// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/task.dart';
import '../../../L1_domain/entities/workspace.dart';
import '../../../L1_domain/entities/ws_role.dart';
import '../../../L1_domain/usecases/task_ext_state.dart';
import '../../extra/services.dart';
import '../task/task_view.dart';

part 'main_controller.g.dart';

class MainController extends _MainControllerBase with _$MainController {}

abstract class _MainControllerBase with Store {
  /// рабочие пространства
  @observable
  ObservableList<Workspace> workspaces = ObservableList();

  @computed
  List<Workspace> get selectableWSs => workspaces.where((ws) => authController.canEditWS(ws.roles)).toList();

  /// рутовый объект
  @observable
  Task rootTask = Task(title: '', closed: false, parent: null, tasks: []);

  /// роли и права доступа
  @computed
  Map<int, Iterable<WSRole>> get _rolesMap => {for (var ws in workspaces) ws.id!: ws.roles};
  Iterable<WSRole> rolesForWS(int? wsId) => _rolesMap[wsId] ?? [];
  // TODO: проблема совместного отображения списка задач из разных РП
  bool get canEditAnyWS => selectableWSs.isNotEmpty;

  /// конкретная задача
  Task taskForId(int? id) => rootTask.allTasks.firstWhereOrNull((t) => t.id == id) ?? rootTask;
  Future showTask(BuildContext context, int? taskId) async {
    await Navigator.of(context).pushNamed(TaskView.routeName, arguments: taskId);
  }

  @action
  Future fetchData(BuildContext? context) async {
    await settingsController.fetchData();
    await accountController.fetchData();
    await referencesController.fetchData();

    workspaces = ObservableList.of(await myUC.getWorkspaces());
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

    await sourceController.fetchData(context);
    // TODO: чтобы сохранять положение в навигации внутри приложения, нужно синхронизировать id текущей выбранной задачи на сервер в профиль пользователя
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
    referencesController.clearData();
    accountController.clearData();
  }

  Future updateAll(BuildContext? context) async {
    loaderController.setLoader(context, titleText: 'Loading...');
    await fetchData(context);
    // TODO: Подумать над фоновым обновлением или обновлением на бэке по расписанию. Иначе каждый запуск приложения — это будет вот это вот всё.
    // TODO: Нужно эту логику на бэк отправить вообще вместе с настройкой частоты обновления для трекера. Чтобы вообще не запускать процесс импорта из клиента.
    if (await importController.updateLinkedTasks()) {
      await fetchData(context);
    }
    loaderController.hideLoader();
  }
}
