// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/task.dart';
import '../../../L1_domain/entities/workspace.dart';
import '../../../L1_domain/entities_extensions/task_stats.dart';
import '../../../L1_domain/entities_extensions/ws_ext.dart';
import '../../../L2_data/services/platform.dart';
import '../../../main.dart';
import '../../components/mt_dialog.dart';
import '../../extra/services.dart';
import '../../presenters/loader_presenter.dart';
import '../../presenters/number_presenter.dart';
import '../../usecases/ws_ext_actions.dart';
import '../tariff/tariff_select_view.dart';
import '../task/task_view.dart';

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

  Future showTask(int wsId, int? taskId) async =>
      await Navigator.of(rootKey.currentContext!).pushNamed(TaskView.routeName, arguments: TaskViewArgs(wsId, taskId));

  @observable
  DateTime? updatedDate;

  @action
  Future fetchWorkspaces() async {
    if (iapController.waitingPayment) {
      loader.set(icon: ldrPurchaseIcon, titleText: loc.loader_purchasing_title);
    } else {
      loader.setRefreshing();
    }

    workspaces = (await myUC.getWorkspaces()).sorted((w1, w2) => compareNatural(w1.title, w2.title));
  }

  Future fetchTasks() async {
    loader.setRefreshing();
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
    updatedDate = null;

    refsController.clearData();
    accountController.clearData();
    notificationController.clearData();
  }

  @action
  Future _update() async {
    loader.start();
    loader.setRefreshing();

    await accountController.fetchData();
    await refsController.fetchData();
    await notificationController.fetchData();

    await fetchWorkspaces();
    await fetchTasks();

    updatedDate = DateTime.now();
    await loader.stop();
  }

  Future _explainUpdateDetails() async {
    if (hasLinkedProjects && !accountController.updateDetailsExplanationViewed) {
      await showMTDialog(
        rootKey.currentContext!,
        title: loc.explain_update_details_dialog_title,
        description: loc.explain_update_details_dialog_description,
        actions: [MTDialogAction(title: loc.ok, type: MTActionType.isDefault, result: true)],
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
        final wantChangeTariff = await showMTDialog(
          rootKey.currentContext!,
          title: loc.onboarding_welcome_gift_dialog_title,
          description: loc.onboarding_welcome_gift_dialog_description(wga.currency),
          actions: [
            MTDialogAction(title: loc.tariff_change_action_title, type: MTActionType.isDefault, result: true),
            MTDialogAction(title: loc.later, result: false),
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
      loader.set(titleText: loc.loader_invitation_redeem_title, icon: ldrAuthIcon);
      invited = await myUC.redeemInvitation(deepLinkController.invitationToken);
      deepLinkController.clearInvitation();
      await loader.stop();
    }
    return invited;
  }

  Future _tryUpdate() async {
    final invited = await _tryRedeemInvitation();
    final timeToUpdate = updatedDate == null || updatedDate!.add(_updatePeriod).isBefore(DateTime.now());
    if (invited || timeToUpdate) {
      await _update();
    } else if (iapController.waitingPayment) {
      loader.start();
      await fetchWorkspaces();
      iapController.resetWaiting();
      await loader.stop();
    }
  }

  // static const _updatePeriod = Duration(hours: 1);
  static const _updatePeriod = Duration(minutes: 30);

  Future _authorizedStartupActions() async {
    if (isIOS) {
      await notificationController.initPush();
    }
    await _tryUpdate();
    await _showOnboarding();
  }

  bool _startupActionsInProgress = false;

  Future startupActions() async {
    if (!_startupActionsInProgress) {
      _startupActionsInProgress = true;
      await serviceSettingsController.fetchSettings();
      await authController.updateAuth();
      if (authController.authorized) {
        await _authorizedStartupActions();
      }
      _startupActionsInProgress = false;
    }
  }

  Future manualUpdate() async {
    await _update();
    await _explainUpdateDetails();
  }
}
