// Copyright (c) 2023. Alexandr Moroz

import 'dart:async';

import 'package:collection/collection.dart';
import 'package:mobx/mobx.dart';

import '../../../../L1_domain/entities/errors.dart';
import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/entities/task_source.dart';
import '../../../../L1_domain/entities/workspace.dart';
import '../../../../L1_domain/entities_extensions/task_members.dart';
import '../../../../L1_domain/entities_extensions/task_source.dart';
import '../../../../L1_domain/entities_extensions/task_state.dart';
import '../../../../L1_domain/entities_extensions/task_stats.dart';
import '../../../../L1_domain/entities_extensions/task_tree.dart';
import '../../../../L1_domain/usecases/task_comparators.dart';
import '../../../extra/services.dart';
import '../../../presenters/task_state.dart';
import '../../../usecases/task_tree.dart';

part 'tasks_main_controller.g.dart';

class TasksMainController extends _TasksMainControllerBase with _$TasksMainController {}

abstract class _TasksMainControllerBase with Store {
  /// проекты и или задачи

  @observable
  ObservableList<Task> allTasks = ObservableList();

  /// проекты

  @computed
  Iterable<Task> get projects => allTasks.where((r) => r.isProject);
  @computed
  bool get hasLinkedProjects => projects.where((p) => p.isLinked).isNotEmpty;
  @computed
  List<MapEntry<TaskState, List<Task>>> get projectsGroups => groups(projects);
  @computed
  List<Task> get dashboardProjects => projectsGroups.isNotEmpty ? projectsGroups.first.value : [];
  @computed
  TaskState get overallProjectsState => attentionalState(projectsGroups);
  @computed
  bool get hasOpenedProjects => projects.where((p) => !p.closed).isNotEmpty;
  @computed
  Iterable<TaskSource> get importingTSs => projects.where((p) => p.isImportingProject).map((p) => p.taskSource!);

  /// задачи

  @computed
  Iterable<Task> get myTasks => allTasks.where(
        (t) => !t.closed && t.assignee != null && t.assignee!.userId == accountController.user!.id && t.isTask,
      );
  @computed
  List<MapEntry<TaskState, List<Task>>> get myTasksGroups => groups(myTasks);
  @computed
  Iterable<Task> get _myDT => myTasks.where((t) => t.hasDueDate);
  @computed
  Iterable<Task> get _myOverdueTasks => _myDT.where((t) => t.hasOverdue);
  @computed
  Iterable<Task> get _myTodayTasks => _myDT.where((t) => t.leafState == TaskState.TODAY);
  @computed
  Iterable<Task> get _myThisWeekTasks => _myDT.where((t) => t.leafState == TaskState.THIS_WEEK);
  @computed
  int get _todayCount => _myOverdueTasks.length + _myTodayTasks.length;
  @computed
  int get myUpcomingTasksCount {
    return _todayCount > 0
        ? _todayCount
        : _myThisWeekTasks.isNotEmpty
            ? _myThisWeekTasks.length
            : myTasks.length;
  }

  @computed
  String get myUpcomingTasksTitle => _myTodayTasks.isNotEmpty
      ? loc.my_tasks_today_title
      : _myThisWeekTasks.isNotEmpty
          ? loc.my_tasks_this_week_title
          : loc.my_tasks_all_title;

  @computed
  Map<int, Map<int, Task>> get _tasksMap => {
        for (var ws in wsMainController.workspaces) ws.id!: {for (var t in _wsTasks(ws.id!)) t.id!: t}
      };

  Iterable<Task> _wsTasks(int wsId) => allTasks.where((t) => t.ws.id == wsId);

  /// задачи из списка

  Task? task(int wsId, int? id) => _tasksMap[wsId]?[id];

  @action
  void addTasks(Iterable<Task> tasks) {
    allTasks.addAll(tasks);
    allTasks.sort(sortByDateAsc);
  }

  @action
  void setTask(Task et) {
    final index = allTasks.indexWhere((t) => t.ws.id == et.ws.id && t.id == et.id);
    if (index > -1) {
      allTasks[index] = et;
    } else {
      allTasks.add(et);
    }
    allTasks.sort(sortByDateAsc);
  }

  @action
  void removeTask(Task task) {
    task.subtasks.toList().forEach((t) => removeTask(t));
    allTasks.remove(task);
  }

  @action
  void removeClosed(Task parent) => allTasks.removeWhere((t) => t.closed && t.parentId == parent.id);

  @action
  Future _getAllTasks() async {
    final _allTasks = <Task>[];
    for (Workspace ws in wsMainController.workspaces) {
      _allTasks.addAll(await myUC.getTasks(ws.id!));
    }
    allTasks = ObservableList.of(_allTasks.sorted(sortByDateAsc));
  }

  Future updateImportingProjects() async {
    await wsMainController.getData();

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
      final wsId = p.ws.id!;
      final existingTask = task(wsId, p.id);
      final existingTS = existingTask?.taskSource;
      final newTS = p.taskSource!;
      if (existingTS?.state != newTS.state) {
        // проект загрузился ок
        if (newTS.isOk) {
          // замена подзадач
          if (existingTask != null) {
            existingTask.subtasks.toList().forEach((t) => removeTask(t));
          }
          addTasks(await myUC.getTasks(p.wsId, parent: p, closed: false));
        }
      }
      // TODO: лишний раз сетится тут, если не было загрузок или изменений статусов
      setTask(p);
    }

    if (importedProjects.where((p) => p.isImportingProject).isNotEmpty) {
      Timer(const Duration(seconds: 5), () async => await updateImportingProjects());
    }
  }

  @action
  void refreshTasks() => allTasks = ObservableList.of(allTasks);

  Future getData() async {
    await _getAllTasks();
    await updateImportingProjects();
  }

  @action
  void clearData() => allTasks.clear();
}
