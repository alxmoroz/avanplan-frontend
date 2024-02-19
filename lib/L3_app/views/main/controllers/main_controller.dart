// Copyright (c) 2023. Alexandr Moroz

import 'dart:async';

import 'package:mobx/mobx.dart';

import '../../../../L1_domain/utils/dates.dart';
import '../../../../L2_data/services/platform.dart';
import '../../../components/images.dart';
import '../../../extra/services.dart';
import '../widgets/app_may_upgrade_dialog.dart';

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
      iapController.resetWaiting();
      loader.stop();
    }
  }

  Future _processAppUpgraded() async {
    if (!localSettingsController.isFirstLaunch) {
      // новая версия
      final oldVersion = localSettingsController.oldVersion;
      final settings = localSettingsController.settings;
      if (oldVersion != settings.version) {
        // действия после обновления версии
        await localSettingsController.resetAppUpgradeProposalDate();
      }
    }
  }

  // static const _updatePeriod = Duration(hours: 1);

  Future _authorizedStartupActions() async {
    await _tryUpdate();
    // await _showOnboarding();
    await notificationController.initPush();
  }

  @observable
  bool _inStartup = false;

  @action
  Future startupActions() async {
    if (!_inStartup) {
      _inStartup = true;

      await serviceSettingsController.getSettings();

      // если нужно обязательно обновить приложение, заставляем обновиться
      if (!isWeb && serviceSettingsController.mustUpgrade) {
        loader.setMustUpgrade();
      } else {
        // если можно обновить приложение, предлагаем обновиться
        if (!isWeb && serviceSettingsController.mayUpgrade && localSettingsController.canAppUpgradeProposal) {
          await showAppMayUpgradeDialog();
          await localSettingsController.setAppUpgradeProposalDate();
        }

        await _processAppUpgraded();

        await authController.checkLocalAuth();
        if (authController.authorized) {
          await _authorizedStartupActions();
        }

        loader.stopInit();

        _inStartup = false;
      }
    }
  }

  void clearData() {
    wsMainController.clearData();
    tasksMainController.clearData();

    _setUpdateDate(null);

    refsController.clearData();
    accountController.clearData();
    notificationController.clearData();
    localSettingsController.clearData();
  }
}
