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
import '../../presenters/number_presenter.dart';
import '../../usecases/ws_ext_actions.dart';
import '../tariff/tariff_select_view.dart';
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
  // TODO: должно частично решиться https://redmine.moroz.team/issues/2566
  void touchWorkspaces() => mainController.myWorkspaces = [...mainController.myWorkspaces];

  /// рутовый объект
  @observable
  Task rootTask = Task(title: '', closed: false, parent: null, tasks: [], members: [], wsId: -1);

  @computed
  Map<int, Task> get _tasksMap => {for (var t in wsTasks(selectedWSId)) t.id!: t};

  Iterable<Task> wsProjects(int wsId) => rootTask.tasks.where((t) => t.wsId == wsId);
  Iterable<Task> wsTasks(int? wsId) => rootTask.allTasks.where((t) => t.wsId == wsId);

  @computed
  bool get hasLinkedProjects => rootTask.tasks.where((p) => p.hasLink).isNotEmpty;

  /// конкретная задача
  Task taskForId(int? id) => _tasksMap[id] ?? rootTask;

  Future showTask(int? taskId) async => await Navigator.of(rootKey.currentContext!).pushNamed(TaskView.routeName, arguments: taskId);

  @observable
  DateTime? updatedDate;

  @action
  Future _fetchWorkspaces() async {
    myWorkspaces = (await myUC.getWorkspaces()).sorted((w1, w2) => compareNatural(w1.title, w2.title));
    // selectedWSId = myWorkspaces.length == 1 ? myWorkspaces.first.id : null;
    selectedWSId = myWorkspaces.first.id;

    final projects = <Task>[];
    for (Workspace ws in myWorkspaces) {
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
  Future fetchData() async {
    loaderController.setRefreshing();
    await settingsController.fetchAppsettings();
    await accountController.fetchData();
    await refsController.fetchData();
    await notificationController.fetchData();

    await _fetchWorkspaces();
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
  Future _update() async {
    loaderController.start();
    await fetchData();
    updatedDate = DateTime.now();
    await loaderController.stop();
  }

  Future _explainUpdateDetails() async {
    if (hasLinkedProjects && !settingsController.explainUpdateDetailsShown) {
      await showMTDialog(
        rootKey.currentContext!,
        title: loc.explain_update_details_dialog_title,
        description: loc.explain_update_details_dialog_description,
        actions: [MTDialogAction(title: loc.ok, type: MTActionType.isDefault, result: true)],
        simple: true,
      );
      await settingsController.setExplainUpdateDetailsShown();
    }
  }

  Future _showWelcomeGiftInfo() async {
    if (selectedWS!.hpTariffUpdate) {
      final wga = selectedWS!.welcomeGiftAmount;
      if (wga > 0 && !settingsController.welcomeGiftInfoShown) {
        final wantChangeTariff = await showMTDialog(
          rootKey.currentContext!,
          title: loc.onboarding_welcome_gift_dialog_title,
          description: loc.onboarding_welcome_gift_dialog_description(wga.currency),
          actions: [
            MTDialogAction(title: loc.tariff_change_action_title, type: MTActionType.isDefault, result: true),
            MTDialogAction(title: loc.later, result: false),
          ],
        );
        await settingsController.setWelcomeGiftInfoShown();

        if (wantChangeTariff == true) {
          await changeTariff(selectedWS!);
        }
      }
    }
  }

  Future _showOnboarding() async {
    await _showWelcomeGiftInfo();
  }

  Future<bool> _redeemInvitation() async {
    loaderController.start();
    loaderController.setRedeemInvitation();
    final invited = await myUC.redeemInvitation(deepLinkController.invitationToken);
    deepLinkController.clearInvitation();
    await loaderController.stop();
    return invited;
  }

  Future _tryUpdate() async {
    final invited = await _redeemInvitation();
    final timeToUpdate = updatedDate == null || updatedDate!.add(_updatePeriod).isBefore(DateTime.now());
    if (paymentController.waitingPayment || invited || timeToUpdate) {
      await _update();
      paymentController.resetWaiting();
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
