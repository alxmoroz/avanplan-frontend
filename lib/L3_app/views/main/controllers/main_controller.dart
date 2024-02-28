// Copyright (c) 2024. Alexandr Moroz

import 'dart:async';

import 'package:mobx/mobx.dart';

import '../../../../L1_domain/utils/dates.dart';
import '../../../components/images.dart';
import '../../../extra/services.dart';

part 'main_controller.g.dart';

class MainController extends _MainControllerBase with _$MainController {}

abstract class _MainControllerBase with Store {
  @observable
  DateTime? _updatedDate;

  @action
  void _setUpdateDate(DateTime? dt) => _updatedDate = dt;

  Future update() async {
    loader.setLoading();
    loader.start();

    await accountController.getData();
    await refsController.getData();
    await notificationController.getData();
    await wsMainController.getData();
    await tasksMainController.getData();

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
    final timeToUpdate = _updatedDate == null; // || _updatedDate!.add(_updatePeriod).isBefore(now);
    if (invited || timeToUpdate) {
      await update();
    } else if (iapController.waitingPayment) {
      loader.set(imageName: 'purchase', titleText: loc.loader_purchasing_title);
      loader.start();
      await wsMainController.getData();
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
    tasksMainController.clearData();
    wsMainController.clearData();
    notificationController.clearData();
    refsController.clearData();
    accountController.clearData();

    _setUpdateDate(null);
  }
}
