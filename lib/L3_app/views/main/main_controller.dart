// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/task.dart';
import '../../../L1_domain/entities/workspace.dart';
import '../../../L1_domain/usecases/task_ext_state.dart';
import '../../../main.dart';
import '../../extra/services.dart';
import '../../usecases/ws_ext_actions.dart';
import '../task/task_view.dart';

part 'main_controller.g.dart';

class MainController extends _MainControllerBase with _$MainController {}

abstract class _MainControllerBase with Store {
  /// рабочие пространства
  @observable
  ObservableList<Workspace> workspaces = ObservableList();

  // TODO: уточнить логику, где нужен этот список и для чего. Можно ли заменить на проверку прав
  @computed
  List<Workspace> get editableWSs => workspaces.where((ws) => ws.canProjectsEdit).toList();

  /// роли и права доступа к РП
  // TODO: заменить на конкретные проверки в местах вызова
  @computed
  bool get canEditAnyWS => editableWSs.isNotEmpty;

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
    workspaces = ObservableList.of(await myUC.getWorkspaces());
    workspaces.sort((w1, w2) => compareNatural(w1.title, w2.title));
    rootTask.tasks = [];
    for (Workspace ws in workspaces) {
      final wsId = ws.id!;
      ws.sources = await sourceUC.getAll(wsId);
      ws.estimateValues = await wsSettingsUC.getEstimateValues(wsId);
      ws.settings = await wsSettingsUC.getSettings(wsId);
      ws.roles = await roleUC.getAll(wsId);

      // List<Status> get _sortedStatuses => statuses.map((s) => s.status).sorted((s1, s2) => compareNatural('$s1', '$s2'));
      // List<Priority> get _sortedPriorities => priorities.map((p) => p.priority).sorted((p1, p2) => compareNatural('$p1', '$p2'));

      final projects = (await taskUC.getRoots(ws.id!)).toList();
      projects.forEach((p) async {
        p.parent = rootTask;
        p.ws = ws;
      });

      rootTask.tasks.addAll(projects);
    }

    updateRootTask();
  }

  @action
  Future fetchData() async {
    loaderController.setRefreshing();
    // TODO: можно завести при открытии соотв. экранов, если тут это не обязательно данные эти
    await accountController.fetchData();
    await refsController.fetchData();
    await notificationController.fetchData();

    await fetchWorkspaces();

    await sourceController.fetchData();
    // TODO: чтобы сохранять положение в навигации внутри приложения, нужно синхронизировать id текущей выбранной задачи на сервер в профиль пользователя
  }

  @action
  void updateRootTask() => rootTask = rootTask.updateRoot();

  @action
  void clearData() {
    workspaces.clear();
    rootTask.tasks = [];
    updatedDate = null;

    sourceController.clearData();
    importController.clearData();
    refsController.clearData();
    accountController.clearData();
  }

  @action
  Future update() async {
    loaderController.start();
    await fetchData();
    await loaderController.stop();
    updatedDate = DateTime.now();
  }

  // static const _updateDuration = Duration(minutes: 30);
  static const _updatePeriod = Duration(hours: 1);
  Future requestUpdate() async {
    if (updatedDate == null || updatedDate!.add(_updatePeriod).isBefore(DateTime.now())) {
      await update();
    }
  }
}
