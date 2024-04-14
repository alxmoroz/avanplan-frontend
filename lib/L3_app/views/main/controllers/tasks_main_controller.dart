// Copyright (c) 2024. Alexandr Moroz

import 'dart:async';

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

  /// Inbox
  @computed
  Task get inbox => allTasks.firstWhere((t) => t.isInbox);

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

  @action
  void addTasks(Iterable<Task> tasks) {
    allTasks.addAll(tasks);
    allTasks.sort();
  }

  @action
  void setTask(Task et) {
    final index = allTasks.indexWhere((t) => t.wsId == et.wsId && t.id == et.id);
    if (index > -1) {
      allTasks[index] = et;
    } else {
      allTasks.add(et);
    }
    allTasks.sort();
  }

  @action
  void removeTask(Task task) {
    task.subtasks.toList().forEach((t) => removeTask(t));
    allTasks.remove(task);
  }

  void updateTasks(Iterable<Task> tasks) {
    for (Task at in tasks) {
      final existingTask = task(at.wsId, at.id);
      if (existingTask != null) {
        existingTask.update(at);
      } else {
        setTask(at);
      }
    }
  }

  @action
  Future getMyProjectsAndTasks() async {
    final tasks = <Task>[];
    for (Workspace ws in wsMainController.workspaces) {
      tasks.addAll(await myUC.getProjects(ws.id!));
      tasks.addAll(await myUC.getMyTasks(ws.id!));
    }
    allTasks = ObservableList.of(tasks);
    allTasks.sort();
  }

  // TODO: только при входе в список проектов?
  Future updateImportingProjects() async {
    final importedProjects = <Task>[];
    for (Workspace ws in wsMainController.workspaces) {
      importedProjects.addAll(await myUC.getProjects(ws.id!, closed: false, imported: true));
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
          // TODO: только если уже были загружены?
          // замена подзадач
          if (existingProject != null) {
            existingProject.subtasks.toList().forEach((t) => removeTask(t));
          }
          // TODO: может и не надо делать этот запрос здесь, а при входе в проект догрузить уже свежую инфу
          // TODO: нужно догрузить только Мои задачи из этого проекта...
          // addTasks(await myUC.getMyTasks(p.wsId, parent: p));
          addTasks(await myUC.getMyTasks(p.wsId));
        }
      }
      // TODO: лишний раз сетится тут, если не было загрузок или изменений статусов
      setTask(p);
    }

    if (importedProjects.where((p) => p.isImportingProject).isNotEmpty) {
      Timer(const Duration(seconds: 10), () async => await updateImportingProjects());
    }
  }

  @action
  void refreshTasks() => allTasks = ObservableList.of(allTasks);

  Future getData() async {
    await getMyProjectsAndTasks();

    // TODO: только при входе в список проектов?
    await updateImportingProjects();
  }

  @action
  void clearData() => allTasks.clear();
}
