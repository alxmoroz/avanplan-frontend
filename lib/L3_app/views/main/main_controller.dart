// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/task.dart';
import '../../../L1_domain/entities/workspace.dart';
import '../../../L1_domain/entities_extensions/task_stats.dart';
import '../../../main.dart';
import '../../extra/services.dart';
import '../task/task_view.dart';
import '../workspace/workspace_view.dart';

part 'main_controller.g.dart';

class MainController extends _MainControllerBase with _$MainController {}

abstract class _MainControllerBase with Store {
  /// рабочие пространства
  @observable
  List<Workspace> myWorkspaces = [];

  Workspace? wsForId(int? wsId) => myWorkspaces.firstWhereOrNull((ws) => ws.id == wsId);

  @observable
  int? selectedWSId;

  @action
  void selectWS(int? _wsId) => selectedWSId = _wsId;

  @computed
  Workspace? get selectedWS => wsForId(selectedWSId);

  Future showWorkspace(int wsId) async {
    selectWS(wsId);
    await Navigator.of(rootKey.currentContext!).pushNamed(WorkspaceView.routeName);
    // TODO: тут надо сбрасывать текущее выбранное РП по идее. Но пока нет явного выбора РП, то оставил без сброса
    // selectWS(null);
  }

  @action
  // TODO: нужен способ дергать обсервер без этих хаков
  void touchWorkspaces() => mainController.myWorkspaces = [...mainController.myWorkspaces];

  /// рутовый объект
  @observable
  Task rootTask = Task(title: '', closed: false, parent: null, tasks: [], members: [], wsId: -1);

  // TODO: пропала уникальность задач по id. Т.к. могут быть из разных БД!!!
  @computed
  Map<int, Task> get _tasksMap => {for (var t in rootTask.allTasks) t.id!: t};

  /// конкретная задача
  Task taskForId(int? id) => _tasksMap[id] ?? rootTask;

  Future showTask(int? taskId) async => await Navigator.of(rootKey.currentContext!).pushNamed(TaskView.routeName, arguments: taskId);

  @observable
  DateTime? updatedDate;

  @action
  Future fetchWorkspaces() async {
    myWorkspaces = (await myUC.getWorkspaces()).sorted((w1, w2) => compareNatural(w1.title, w2.title));
    selectedWSId = myWorkspaces.length == 1 ? myWorkspaces.first.id : null;

    rootTask.tasks = [];
    for (Workspace ws in myWorkspaces) {
      final projects = (await taskUC.getRoots(ws.id!)).toList();
      projects.forEach((p) async {
        p.parent = rootTask;
      });

      rootTask.tasks.addAll(projects);
    }

    updateRootTask();
  }

  @action
  Future fetchData() async {
    loaderController.setRefreshing();
    await settingsController.fetchAppsettings();
    // TODO: можно завести при открытии соотв. экранов, если тут это не обязательно данные эти
    await accountController.fetchData();
    await refsController.fetchData();
    await notificationController.fetchData();

    await fetchWorkspaces();

    // TODO: чтобы сохранять положение в навигации внутри приложения, нужно синхронизировать id текущей выбранной задачи на сервер в профиль пользователя
  }

  @action
  void updateRootTask() => rootTask = rootTask.updateRoot();

  @action
  void clearData() {
    myWorkspaces = [];
    rootTask.tasks = [];
    updateRootTask();
    updatedDate = null;

    refsController.clearData();
    accountController.clearData();
    notificationController.clearData();
  }

  @action
  Future update() async {
    loaderController.start();
    await fetchData();
    await loaderController.stop();
    updatedDate = DateTime.now();
  }

  // static const _updatePeriod = Duration(minutes: 30);
  static const _updatePeriod = Duration(hours: 1);
  Future requestUpdate() async {
    final hasDeepLinks = await deepLinkController.processDeepLinks();
    final timeToUpdate = updatedDate == null || updatedDate!.add(_updatePeriod).isBefore(DateTime.now());
    if (paymentController.waitingPayment || hasDeepLinks || timeToUpdate) {
      await update();
      paymentController.resetWaiting();
    }
  }
}
