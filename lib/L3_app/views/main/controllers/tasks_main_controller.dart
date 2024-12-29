// Copyright (c) 2024. Alexandr Moroz

import 'dart:async';

import 'package:collection/collection.dart';
import 'package:mobx/mobx.dart';

import '../../../../L1_domain/entities/errors.dart';
import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/entities/task_source.dart';
import '../../../../L1_domain/entities/workspace.dart';
import '../../../../L1_domain/entities_extensions/task_source.dart';
import '../../../../L1_domain/entities_extensions/task_type.dart';
import '../../../presenters/task_tree.dart';
import '../../app/services.dart';
import '../../task/usecases/edit.dart';
import '../../task/usecases/state.dart';

part 'tasks_main_controller.g.dart';

class TasksMainController extends _TasksMainControllerBase with _$TasksMainController {
  Iterable<int> _absentTasksIds(int wsId, Iterable<int> tasksIds) => tasksIds.where((id) => task(wsId, id) == null);

  Future<Iterable<Task>> _loadTasks(int wsId, Iterable<int> tasksIds) async {
    final loadedTasks = <Task>[];
    final absentTasksIds = _absentTasksIds(wsId, tasksIds);
    if (absentTasksIds.isNotEmpty) {
      loadedTasks.addAll(await taskUC.tasksList(wsId, absentTasksIds));
      final parentsIds = loadedTasks.where((t) => t.parentId != null).map((t) => t.parentId!);
      if (parentsIds.isNotEmpty) {
        loadedTasks.addAll(await _loadTasks(wsId, parentsIds));
      }
    }
    return loadedTasks;
  }

  Future<int> loadTasksIfAbsent(int wsId, Iterable<int> tasksIds) async {
    final loadedTasks = await _loadTasks(wsId, tasksIds);
    final availableTasks = loadedTasks.where((t) => !t.isForbidden);
    if (availableTasks.isNotEmpty) {
      upsertTasks(availableTasks);
      refreshUI();
    }
    return loadedTasks.where((t) => t.isForbidden).length;
  }

  /// задачи из списка
  Map<int, Map<int, Task>> get _tasksMap => {
        for (var ws in wsMainController.workspaces) ws.id!: {for (var t in _wsTasks(ws.id!)) t.id!: t}
      };

  Iterable<Task> _wsTasks(int wsId) => allTasks.where((t) => t.wsId == wsId);

  Task? task(int wsId, int? id) => _tasksMap[wsId]?[id];

  void upsertTasks(Iterable<Task> tasks) {
    for (Task et in tasks) {
      final index = allTasks.indexWhere((t) => t.wsId == et.wsId && t.id == et.id);
      if (index > -1) {
        allTasks[index] = allTasks[index].refill(et);
      } else {
        allTasks.add(et);
      }
    }
    allTasks.sort();
  }

  void removeTask(Task task) {
    task.subtasks.toList().forEach((t) => removeTask(t));
    allTasks.remove(task);
  }

  void _setupImportingProjectsRefreshTimer() {
    if (_importingProjects.isNotEmpty) {
      Timer(const Duration(seconds: 10), () async => await updateImportingProjects());
    }
  }

  Future reload() async {
    final tasks = <Task>[];

    // мои проекты и задачи
    for (Workspace ws in wsMainController.workspaces) {
      tasks.addAll(await wsMyUC.myProjects(ws.id!));
      tasks.addAll(await wsMyUC.myTasks(ws.id!));
    }

    tasks.sort();
    refreshUI(tasks);

    _setupImportingProjectsRefreshTimer();
  }

  Future updateImportingProjects() async {
    final importedProjects = <Task>[];
    for (Workspace ws in wsMainController.workspaces) {
      importedProjects.addAll(await wsMyUC.myProjects(ws.id!, closed: false, imported: true));
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
          upsertTasks(await wsMyUC.myTasks(p.wsId, projectId: p.id));
        }
      }
      // TODO: лишний раз сетится тут, если не было загрузок или изменений статусов
      upsertTasks([p]);
    }
    refreshUI();

    _setupImportingProjectsRefreshTimer();
  }
}

abstract class _TasksMainControllerBase with Store {
  @observable
  ObservableList<Task> allTasks = ObservableList();

  @action
  void refreshUI([Iterable<Task>? tasks]) => allTasks = ObservableList.of(tasks ?? allTasks);

  @action
  void clear() => allTasks.clear();

  /// Inbox
  @computed
  Task? get inbox => allTasks.firstWhereOrNull((t) => t.isInbox);

  /// проекты
  @computed
  Iterable<Task> get projects => allTasks.where((t) => t.isProject);

  @computed
  List<MapEntry<TaskState, List<Task>>> get projectsGroups => groups(projects);

  @computed
  Iterable<Task> get openedProjects => projects.where((p) => !p.closed);
  @computed
  bool get hasOpenedProjects => openedProjects.isNotEmpty;
  @computed
  bool get isAllProjectsClosed => projects.isNotEmpty && !hasOpenedProjects;

  @computed
  Iterable<Task> get _importingProjects => projects.where((p) => p.isImportingProject);

  @computed
  Iterable<TaskSource> get importingTSs => _importingProjects.map((p) => p.taskSource!);

  /// задачи

  @computed
  Iterable<Task> get tasks => allTasks.where((t) => t.isTask);
  @computed
  Iterable<Task> get openedTasks => tasks.where((t) => !t.closed);

  // TODO: тут не учитываются не загруженные задачи с бэка
  @computed
  bool get hasOpenedTasks => openedTasks.isNotEmpty;

  // Для определения необходимости показывать шаг с добавлением задач в онбординге
  @computed
  bool get hasAnyTasks => projects.isNotEmpty || tasks.isNotEmpty || (inbox?.closedSubtasksCount ?? 0) > 0;

  @computed
  Iterable<Task> get myTasks => openedTasks.where((t) => t.assignedToMe);

  /// логика экрана Ближайшие дела
  @computed
  bool get freshStart => !hasOpenedProjects && !hasOpenedTasks;
  @computed
  bool get canPlan => hasOpenedProjects || hasOpenedTasks;
}
