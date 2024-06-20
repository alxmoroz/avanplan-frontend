// Copyright (c) 2024. Alexandr Moroz

import 'dart:async';

import 'package:collection/collection.dart';
import 'package:mobx/mobx.dart';

import '../../../../L1_domain/entities/next_task_or_event.dart';
import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/utils/dates.dart';
import '../../../components/images.dart';
import '../../../extra/router.dart';
import '../../../extra/services.dart';
import '../../../views/_base/loadable.dart';

part 'main_controller.g.dart';

class MainController extends _MainControllerBase with _$MainController {}

abstract class _MainControllerBase with Store, Loadable {
  @computed
  List<MapEntry<TaskState, List<NextTaskOrEvent>>> get nextTasksOrEventsDateGroups {
    final nextTasksOrEvents = [
      ...tasksMainController.myTasks.map((t) => NextTaskOrEvent(t.dueDate, t)),
      ...calendarController.events.map((e) => NextTaskOrEvent(e.startDate, e)),
    ].sorted((n1, n2) => n1.compareTo(n2));

    final ge = groupBy<NextTaskOrEvent, TaskState>(nextTasksOrEvents, (nte) => nte.state);
    return ge.entries.sortedBy<num>((g) => g.key.index);
  }

  @observable
  DateTime? _updatedDate;

  @action
  void _setUpdateDate(DateTime? dt) => _updatedDate = dt;

  Future _reloadData() async {
    await accountController.reload();
    await refsController.reload();
    await notificationController.reload();
    await wsMainController.reload();
    await tasksMainController.reload();
    await calendarController.reload();

    _setUpdateDate(now);
  }

  @override
  startLoading() {
    setLoaderScreenLoading();
    super.startLoading();
  }

  Future reload() async => await load(_reloadData);

  // Future _showOnboarding() async {}

  Future<bool> _tryRedeemInvitation() async {
    bool invited = false;
    if (invitationTokenController.hasToken) {
      setLoaderScreen(titleText: loc.loader_invitation_redeem_title, imageName: ImageName.privacy.name);
      final token = invitationTokenController.token!;
      invitationTokenController.clear();
      invited = await myUC.redeemInvitation(token);
    }
    return invited;
  }

  Future _tryUpdate() async {
    final invited = await _tryRedeemInvitation();
    final isTimeToUpdate = _updatedDate == null; // || _updatedDate!.add(_updatePeriod).isBefore(now);
    if (invited || isTimeToUpdate || router.isDeepLink) {
      await _reloadData();
    }
  }

  // static const _updatePeriod = Duration(hours: 1);

  @action
  Future startup() async {
    await appController.startup();

    await authController.checkLocalAuth();
    if (authController.authorized) {
      await load(() async {
        // await _showOnboarding();
        await notificationController.setup();
        await _tryUpdate();
      });
    } else {
      authController.signOut();
    }
  }

  void clear() {
    calendarController.clear();
    tasksMainController.clear();
    wsMainController.clear();
    notificationController.clear();
    refsController.clear();
    accountController.clear();

    _setUpdateDate(null);
  }
}
