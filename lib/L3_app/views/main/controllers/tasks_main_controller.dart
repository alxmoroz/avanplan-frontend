// Copyright (c) 2024. Alexandr Moroz

import 'dart:async';

import 'package:collection/collection.dart';
import 'package:mobx/mobx.dart';

import '../../../../L1_domain/entities/errors.dart';
import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/entities/task_source.dart';
import '../../../../L1_domain/entities/workspace.dart';
import '../../../../L1_domain/entities_extensions/task_source.dart';
import '../../../../L1_domain/entities_extensions/task_stats.dart';
import '../../../../L1_domain/entities_extensions/task_tree.dart';
import '../../../extra/services.dart';
import '../../../presenters/task_state.dart';
import '../../../usecases/task_edit.dart';
import '../../../usecases/task_tree.dart';

part 'tasks_main_controller.g.dart';

class TasksMainController extends _TasksMainControllerBase with _$TasksMainController {}

abstract class _TasksMainControllerBase with Store {
  /// проекты и или задачи

  @observable
  ObservableList<Task> allTasks = ObservableList();

  @action
  void refreshTasksUI() => allTasks = ObservableList.of(allTasks);

  /// Inbox
  @computed
  Task? get inbox => allTasks.firstWhereOrNull((t) => t.isInbox);

  /// проекты
  @computed
  Iterable<Task> get projects => allTasks.where((t) => t.isProject);
  @computed
  bool get hasLinkedProjects => projects.where((p) => p.isLinked).isNotEmpty;
  @computed
  List<MapEntry<TaskState, List<Task>>> get projectsGroups => groups(projects);
  @computed
  List<Task> get dashboardProjects => projectsGroups.isNotEmpty ? projectsGroups.first.value : [];
  @computed
  TaskState get overallProjectsState => attentionalState(projectsGroups);
  @computed
  Iterable<Task> get openedProjects => projects.where((p) => !p.closed);
  @computed
  bool get hasOpenedProjects => openedProjects.isNotEmpty;
  @computed
  bool get isAllProjectsClosed => projects.isNotEmpty && !hasOpenedProjects;

  @computed
  Iterable<TaskSource> get importingTSs => projects.where((p) => p.isImportingProject).map((p) => p.taskSource!);

  /// задачи

  Iterable<Task> get tasks => allTasks.where((t) => t.isTask);
  Iterable<Task> get openedTasks => tasks.where((t) => !t.closed);
  // TODO: тут не учитываются не загруженные задачи с бэка
  @computed
  bool get hasOpenedTasks => openedTasks.isNotEmpty;

  @computed
  Iterable<Task> get myTasks => openedTasks.where((t) => t.assignedToMe);

  @computed
  Map<int, Map<int, Task>> get _tasksMap => {
        for (var ws in wsMainController.workspaces) ws.id!: {for (var t in _wsTasks(ws.id!)) t.id!: t}
      };

  Iterable<Task> _wsTasks(int wsId) => allTasks.where((t) => t.wsId == wsId);

  /// логика экрана Ближайшие дела
  @computed
  bool get freshStart => !hasOpenedProjects && !hasOpenedTasks;
  @computed
  bool get canPlan => hasOpenedProjects || hasOpenedTasks;

  /// задачи из списка

  Task? task(int wsId, int? id) => _tasksMap[wsId]?[id];

  void _setTask(Task et, bool refill) {
    final index = allTasks.indexWhere((t) => t.wsId == et.wsId && t.id == et.id);
    if (index > -1) {
      allTasks[index] = refill ? allTasks[index].refill(et) : et;
    } else {
      allTasks.add(et);
    }
  }

  // TODO: сделать приватным. Выделить ВИ под разную логику использования этого метода
  @action
  void setTasks(Iterable<Task> tasks, {bool refill = false}) {
    for (Task et in tasks) {
      _setTask(et, refill);
    }
    allTasks.sort();
  }

  // TODO: сделать приватным. Выделить ВИ под разную логику использования этого метода
  void setTask(Task et) => setTasks([et]);

  void _removeTask(Task task) {
    task.subtasks.toList().forEach((t) => _removeTask(t));
    allTasks.remove(task);
  }

  @action
  void removeTask(Task task) {
    _removeTask(task);
    refreshTasksUI();
  }

  @action
  Future _reloadMyProjectsAndTasks() async {
    allTasks.clear();
    for (Workspace ws in wsMainController.workspaces) {
      allTasks.addAll(await wsUC.getProjects(ws.id!));
      allTasks.addAll(await wsUC.getMyTasks(ws.id!));
    }
    allTasks.sort();
  }

  Future updateImportingProjects() async {
    final importedProjects = <Task>[];
    for (Workspace ws in wsMainController.workspaces) {
      importedProjects.addAll(await wsUC.getProjects(ws.id!, closed: false, imported: true));
    }

    for (Task p in importedProjects) {
      if (p.taskSource!.hasError) {
        p.error = MTError(
          loc.error_import_title,
          description: p.taskSource!.stateDetails,
        );
      }
      final existingProject = task(p.wsId, p.id);
      final newTS = p.taskSource!;
      if (existingProject?.taskSource?.state != newTS.state) {
        // проект загрузился ок
        if (newTS.isOk) {
          // замена подзадач
          if (existingProject != null) {
            existingProject.subtasks.toList().forEach((t) => removeTask(t));
          }
          setTasks(await wsUC.getMyTasks(p.wsId, projectId: p.id));
        }
      }
      // TODO: лишний раз сетится тут, если не было загрузок или изменений статусов
      setTask(p);
    }

    if (importedProjects.where((p) => p.isImportingProject).isNotEmpty) {
      Timer(const Duration(seconds: 10), () async => await updateImportingProjects());
    }
  }

  Future reload() async {
    await _reloadMyProjectsAndTasks();
    await updateImportingProjects();
  }

  @action
  void clear() => allTasks.clear();
}
