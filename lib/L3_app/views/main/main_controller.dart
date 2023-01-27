// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/task.dart';
import '../../../L1_domain/entities/workspace.dart';
import '../../../L1_domain/entities/ws_role.dart';
import '../../../L1_domain/usecases/task_ext_state.dart';
import '../../../main.dart';
import '../../extra/services.dart';
import '../task/task_view.dart';

part 'main_controller.g.dart';

class MainController extends _MainControllerBase with _$MainController {}

abstract class _MainControllerBase with Store {
  /// рабочие пространства
  @observable
  ObservableList<Workspace> workspaces = ObservableList();

  @computed
  List<Workspace> get editableWSs => workspaces.where((ws) => authController.canEditWS(ws.roles)).toList();

  /// рутовый объект
  @observable
  Task rootTask = Task(title: '', closed: false, parent: null, tasks: []);

  @computed
  Map<int, Task> get _tasksMap => {for (var t in rootTask.allTasks) t.id!: t};

  /// конкретная задача
  Task taskForId(int? id) => _tasksMap[id] ?? rootTask;

  /// роли и права доступа
  @computed
  Map<int, Iterable<WSRole>> get _rolesMap => {for (var ws in workspaces) ws.id!: ws.roles};
  Iterable<WSRole> rolesForWS(int? wsId) => _rolesMap[wsId] ?? [];
  // TODO: проблема совместного отображения списка задач из разных РП
  bool get canEditAnyWS => editableWSs.isNotEmpty;

  Future showTask(int? taskId) async => await Navigator.of(rootKey.currentContext!).pushNamed(TaskView.routeName, arguments: taskId);

  /// рабочие пространства, справочники и задачи

  @observable
  DateTime? updatedDate;

  @action
  Future fetchWorkspaces() async {
    workspaces = ObservableList.of(await myUC.getWorkspaces());
    workspaces.sort((w1, w2) => compareNatural(w1.title, w2.title));
    final tasks = <Task>[];
    for (Workspace ws in workspaces) {
      ws.sources = await sourcesUC.getAll(ws.id!);
      ws.sources.forEach((s) => s.workspaceId = ws.id!);

      // TODO: сортируем тут только те списки, которые не редактируем в приложении на данный момент. Нужно перенести в контроллеры для редактирования
      // List<Status> get _sortedStatuses => statuses.map((s) => s.status).sorted((s1, s2) => compareNatural('$s1', '$s2'));
      // List<Priority> get _sortedPriorities => priorities.map((p) => p.priority).sorted((p1, p2) => compareNatural('$p1', '$p2'));
      // List<Person> get _sortedPersons => persons.map((p) => p.person).sorted((p1, p2) => compareNatural('$p1', '$p2'));
      // List<Estimate> get _sortedEstimates => estimates.map((e) => e.estimate).sorted((e1, e2) => compareNatural('$e1', '$e2'));
      // sourceTypes = ObservableList.of((await sourceTypesUC.getAll()).sorted((s1, s2) => compareNatural(s1.code, s2.code)));

      // TODO: для гостевых ролей в памяти приложения доступна инфа, которая может быть конфиденц. Нужно не отдавать с бэка лишнее.
      // TODO: сделать отдельные эндпойнты с контролем прав на бэкенде

      final projects = await tasksUC.getRoots(ws.id!);
      projects.forEach((p) {
        p.parent = rootTask;
        p.workspaceId = ws.id!;
      });

      tasks.addAll(projects);
    }

    rootTask.tasks = tasks;
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
