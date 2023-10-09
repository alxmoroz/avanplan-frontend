// Copyright (c) 2022. Alexandr Moroz

import 'dart:async';

import 'package:collection/collection.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/task.dart';
import '../../../L1_domain/entities/task_source.dart';
import '../../../L1_domain/entities/workspace.dart';
import '../../../L1_domain/entities_extensions/task_members.dart';
import '../../../L1_domain/entities_extensions/task_source.dart';
import '../../../L1_domain/entities_extensions/task_state.dart';
import '../../../L1_domain/entities_extensions/task_stats.dart';
import '../../../L1_domain/entities_extensions/task_tree.dart';
import '../../../L1_domain/entities_extensions/ws_accounts.dart';
import '../../../L1_domain/usecases/task_comparators.dart';
import '../../../L2_data/services/platform.dart';
import '../../components/alert_dialog.dart';
import '../../components/images.dart';
import '../../extra/services.dart';
import '../../presenters/number.dart';
import '../../presenters/task_filter.dart';
import '../../presenters/task_state.dart';
import '../../presenters/task_tree.dart';
import '../../usecases/ws_actions.dart';
import '../../usecases/ws_tariff.dart';

part 'main_controller.g.dart';

class MainController extends _MainControllerBase with _$MainController {}

abstract class _MainControllerBase with Store {
  /// рабочие пространства
  @observable
  List<Workspace> workspaces = [];

  @computed
  Iterable<Workspace> get myWSs => workspaces.where((ws) => ws.isMine);

  Workspace wsForId(int wsId) => workspaces.firstWhere((ws) => ws.id == wsId);

  @action
  // TODO: нужен способ дергать обсервер без этих хаков
  void touchWorkspaces() => workspaces = [...workspaces];

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
  List<Task> get attentionalProjects => attentionalTasks(projectsGroups);
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
        for (var ws in workspaces) ws.id!: {for (var t in _wsTasks(ws.id!)) t.id!: t}
      };

  Iterable<Task> _wsTasks(int wsId) => allTasks.where((t) => t.ws.id == wsId);

  /// задачи из списка

  Task? task(int wsId, int? id) => _tasksMap[wsId]![id];

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

  @observable
  DateTime? _updatedDate;

  @action
  Future fetchWorkspaces() async {
    if (iapController.waitingPayment) {
      loader.set(imageName: 'purchase', titleText: loc.loader_purchasing_title);
    } else {
      loader.setLoading();
    }

    workspaces = (await myUC.getWorkspaces()).sorted((w1, w2) => compareNatural(w1.title, w2.title));
  }

  @action
  Future fetchTasks() async {
    loader.setLoading();
    final _allTasks = <Task>[];
    for (Workspace ws in workspaces) {
      _allTasks.addAll(await myUC.getTasks(ws));
    }
    allTasks = ObservableList.of(_allTasks.sorted(sortByDateAsc));
  }

  @action
  Future updateImportingProjects() async {
    final importedProjects = <Task>[];
    for (Workspace ws in workspaces) {
      importedProjects.addAll(await myUC.getProjects(ws, closed: false, imported: true));
    }

    for (Task p in importedProjects) {
      final existingTask = task(p.ws.id!, p.id);
      final existingTS = existingTask?.taskSource;
      final newTS = p.taskSource!;
      if (existingTS?.state != newTS.state) {
        // замена подзадач
        if (newTS.isOk) {
          if (existingTask != null) {
            removeTask(existingTask);
          }
          addTasks(await myUC.getTasks(p.ws, parent: p, closed: false));
        }
      }
      setTask(p);
    }

    if (importedProjects.where((p) => p.isImportingProject).isNotEmpty) {
      Timer(const Duration(seconds: 5), () async => await updateImportingProjects());
    }
  }

  @action
  void refresh() => allTasks = ObservableList.of(allTasks);

  @action
  void clearData() {
    workspaces = [];
    allTasks.clear();
    _updatedDate = null;

    refsController.clearData();
    accountController.clearData();
    notificationController.clearData();
    localSettingsController.clearData();
  }

  @action
  Future _update() async {
    loader.start();
    loader.setLoading();

    await accountController.fetchData();
    await refsController.fetchData();
    await notificationController.fetchData();

    await fetchWorkspaces();
    await fetchTasks();
    await updateImportingProjects();

    _updatedDate = DateTime.now();
    await loader.stop();
  }

  Future _explainUpdateDetails() async {
    if (hasLinkedProjects && !accountController.updateDetailsExplanationViewed) {
      await showMTAlertDialog(
        loc.explain_update_details_dialog_title,
        description: loc.explain_update_details_dialog_description,
        actions: [MTADialogAction(title: loc.ok, type: MTActionType.isDefault, result: true)],
        simple: true,
      );
      await accountController.setUpdateDetailsExplanationViewed();
    }
  }

  Future _showWelcomeGiftInfo() async {
    if (myWSs.isNotEmpty) {
      // TODO: берем первый попавшийся. Нужно изменить триггер для показа инфы о приветственном балансе
      final myWS = myWSs.first;
      final wga = myWS.welcomeGiftAmount;
      final wsId = myWS.id;
      if (wga > 0 && !accountController.welcomeGiftInfoViewed(wsId!)) {
        final wantChangeTariff = await showMTAlertDialog(
          loc.onboarding_welcome_gift_dialog_title,
          description: loc.onboarding_welcome_gift_dialog_description(wga.currency),
          actions: [
            MTADialogAction(title: loc.tariff_change_action_title, type: MTActionType.isDefault, result: true),
            MTADialogAction(title: loc.later, result: false),
          ],
        );
        await accountController.setWelcomeGiftInfoViewed(wsId);

        if (wantChangeTariff == true) {
          await myWS.changeTariff();
        }
      }
    }
  }

  Future _showOnboarding() async {
    await _showWelcomeGiftInfo();
  }

  Future<bool> _tryRedeemInvitation() async {
    bool invited = false;
    if (deepLinkController.hasInvitation) {
      loader.start();
      loader.set(titleText: loc.loader_invitation_redeem_title, imageName: ImageName.privacy.name);
      invited = await myUC.redeemInvitation(deepLinkController.invitationToken);
      deepLinkController.clearInvitation();
      await loader.stop();
    }
    return invited;
  }

  Future _tryUpdate() async {
    final invited = await _tryRedeemInvitation();
    final timeToUpdate = _updatedDate == null || _updatedDate!.add(_updatePeriod).isBefore(DateTime.now());
    if (invited || timeToUpdate) {
      await _update();
    } else if (iapController.waitingPayment) {
      loader.start();
      await fetchWorkspaces();
      iapController.resetWaiting();
      await loader.stop();
    }
  }

  Future _checkAppUpgrade() async {
    if (!localSettingsController.isFirstLaunch) {
      // новая версия
      final oldVersion = localSettingsController.oldVersion;
      final settings = localSettingsController.settings;
      if (oldVersion != settings.version) {
        // обновление с 1.0 на более новую
        if (oldVersion.startsWith('1.0')) {
          if (settings.getFlag('EXPLAIN_UPDATE_DETAILS_SHOWN')) {
            await accountController.setUpdateDetailsExplanationViewed();
          }
          if (settings.getFlag('WELCOME_GIFT_INFO_SHOWN')) {
            for (final ws in mainController.myWSs) {
              await accountController.setWelcomeGiftInfoViewed(ws.id!);
            }
          }
        }
      }
    }
  }

  // static const _updatePeriod = Duration(hours: 1);
  static const _updatePeriod = Duration(minutes: 30);

  Future _authorizedStartupActions() async {
    await _tryUpdate();
    await _checkAppUpgrade();
    await _showOnboarding();
    if (isIOS) {
      await notificationController.initPush();
    }
  }

  // TODO: пригодится блокировка от возможного повторного запуска в том же потоке
  Future startupActions() async {
    await serviceSettingsController.fetchSettings();
    await authController.checkLocalAuth();
    if (authController.authorized) {
      await _authorizedStartupActions();
    }

    loader.stopInit();
  }

  Future manualUpdate() async {
    await _update();
    await _explainUpdateDetails();
  }
}
