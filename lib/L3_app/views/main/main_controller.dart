// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/task.dart';
import '../../../L1_domain/entities/workspace.dart';
import '../../../L1_domain/entities_extensions/task_members.dart';
import '../../../L1_domain/entities_extensions/task_stats.dart';
import '../../../L1_domain/entities_extensions/ws_ext.dart';
import '../../../L2_data/services/platform.dart';
import '../../../main.dart';
import '../../components/images.dart';
import '../../components/mt_alert_dialog.dart';
import '../../extra/services.dart';
import '../../presenters/date_presenter.dart';
import '../../presenters/number_presenter.dart';
import '../../presenters/task_comparators.dart';
import '../../usecases/ws_ext_actions.dart';
import '../tariff/tariff_select_view.dart';
import '../task/task_view.dart';
import '../task/task_view_controller.dart';

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
  // TODO: должно частично решиться https://redmine.moroz.team/issues/2566
  void touchWorkspaces() => workspaces = [...workspaces];

  /// рутовый объект
  @observable
  Task rootTask = Task(title: '', closed: false, parent: null, tasks: [], members: [], wsId: 0);

  @computed
  List<Task> get myTasks => rootTask.openedAssignedLeafTasks.where((t) => t.assignee!.userId == accountController.user!.id).sorted(sortByDateAsc);
  @computed
  Iterable<Task> get myDueTasks => myTasks.where((t) => t.hasDueDate);
  @computed
  Iterable<Task> get myDueTasksToday => myDueTasks.where((t) => t.dueDate!.isBefore(tomorrow));
  @computed
  Iterable<Task> get myDueTasksWeek => myDueTasks.where((t) => t.dueDate!.isBefore(nextWeek));

  @computed
  int get myUpcomingTasksCount => myDueTasksToday.isNotEmpty
      ? myDueTasksToday.length
      : myDueTasksWeek.isNotEmpty
          ? myDueTasksWeek.length
          : myTasks.length;

  @computed
  String get myUpcomingTasksTitle => myDueTasksToday.isNotEmpty
      ? loc.task_list_my_today_title
      : myDueTasksWeek.isNotEmpty
          ? loc.task_list_my_week_title
          : loc.task_list_my_future_title;

  @computed
  Map<int, Map<int, Task>> get _tasksMap => {
        for (var ws in workspaces) ws.id!: {for (var t in wsTasks(ws.id!)) t.id!: t}
      };

  Iterable<Task> wsProjects(int wsId) => rootTask.tasks.where((t) => t.wsId == wsId);
  Iterable<Task> wsTasks(int wsId) => rootTask.allTasks.where((t) => t.wsId == wsId);

  @computed
  bool get hasLinkedProjects => rootTask.tasks.where((p) => p.hasLink).isNotEmpty;

  /// конкретная задача
  Task taskForId(int wsId, int? id) {
    Task? t;
    if (wsId > 0 && id != null) {
      t = _tasksMap[wsId]![id];
    }
    return t ?? rootTask;
  }

  Future showTask(TaskParams tp) async => await Navigator.of(rootKey.currentContext!).pushNamed(TaskView.routeName, arguments: tp);

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

  Future fetchTasks() async {
    loader.setLoading();
    final projects = <Task>[];
    for (Workspace ws in workspaces) {
      final roots = (await taskUC.getRoots(ws.id!)).toList();
      roots.forEach((p) async {
        p.parent = rootTask;
      });
      projects.addAll(roots);
    }
    rootTask.tasks = projects;
    updateRootTask();
  }

  @action
  void updateRootTask() => rootTask = rootTask.updateRoot();

  @action
  void clearData() {
    workspaces = [];
    rootTask.tasks = [];
    updateRootTask();
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

    _updatedDate = DateTime.now();
    await loader.stop();
  }

  Future _explainUpdateDetails() async {
    if (hasLinkedProjects && !accountController.updateDetailsExplanationViewed) {
      await showMTAlertDialog(
        rootKey.currentContext!,
        title: loc.explain_update_details_dialog_title,
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
          rootKey.currentContext!,
          title: loc.onboarding_welcome_gift_dialog_title,
          description: loc.onboarding_welcome_gift_dialog_description(wga.currency),
          actions: [
            MTADialogAction(title: loc.tariff_change_action_title, type: MTActionType.isDefault, result: true),
            MTADialogAction(title: loc.later, result: false),
          ],
        );
        await accountController.setWelcomeGiftInfoViewed(wsId);

        if (wantChangeTariff == true) {
          await changeTariff(myWS);
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
      loader.set(titleText: loc.loader_invitation_redeem_title, imageName: ImageNames.privacy);
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
  }

  Future manualUpdate() async {
    await _update();
    await _explainUpdateDetails();
  }
}
