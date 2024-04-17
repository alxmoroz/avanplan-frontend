// Copyright (c) 2024. Alexandr Moroz

import 'dart:async';

import 'package:collection/collection.dart';
import 'package:mobx/mobx.dart';

import '../../../../L1_domain/entities/next_task_or_event.dart';
import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/utils/dates.dart';
import '../../../components/images.dart';
import '../../../extra/services.dart';

part 'main_controller.g.dart';

class MainController extends _MainControllerBase with _$MainController {}

abstract class _MainControllerBase with Store {
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

  Future update() async {
    loader.setLoading();
    loader.start();

    await accountController.reload();
    await refsController.reload();
    await notificationController.reload();
    await wsMainController.reload();
    await tasksMainController.reload();
    await calendarController.reload();

    _setUpdateDate(now);
    await loader.stop();
  }

  // Future _showOnboarding() async {}

  Future<bool> _tryRedeemInvitation() async {
    bool invited = false;
    if (invitationTokenController.hasToken) {
      loader.set(titleText: loc.loader_invitation_redeem_title, imageName: ImageName.privacy.name);
      loader.start();
      final token = invitationTokenController.token!;
      invitationTokenController.clear();

      invited = await myUC.redeemInvitation(token);
      loader.stop();
    }
    return invited;
  }

  Future _tryUpdate() async {
    final invited = await _tryRedeemInvitation();
    final isTimeToUpdate = _updatedDate == null; // || _updatedDate!.add(_updatePeriod).isBefore(now);
    if (invited || isTimeToUpdate) {
      await update();
    } else if (iapController.waitingPayment) {
      loader.set(imageName: 'purchase', titleText: loc.loader_purchasing_title);
      loader.start();
      await wsMainController.reload();
      iapController.reset();
      loader.stop();
    }
  }

  // static const _updatePeriod = Duration(hours: 1);

  @action
  Future startupActions() async {
    await appController.initState(authorizedActions: () async {
      await _tryUpdate();
      // await _showOnboarding();
      await notificationController.initPush();
    });
  }

  void clearData() {
    calendarController.clear();
    tasksMainController.clearData();
    wsMainController.clearData();
    notificationController.clearData();
    refsController.clear();
    accountController.clear();

    _setUpdateDate(null);
  }
}
