// Copyright (c) 2023. Alexandr Moroz

import 'dart:async';

import 'package:mobx/mobx.dart';

import '../../../../L1_domain/utils/dates.dart';
import '../../../../L2_data/services/platform.dart';
import '../../../components/alert_dialog.dart';
import '../../../components/images.dart';
import '../../../extra/services.dart';

part 'main_controller.g.dart';

class MainController extends _MainControllerBase with _$MainController {}

abstract class _MainControllerBase with Store {
  @observable
  DateTime? _updatedDate;

  @action
  void _setUpdateDate(DateTime? dt) => _updatedDate = dt;

  Future _update() async {
    loader.start();
    loader.setLoading();

    await accountController.getData();
    await refsController.getData();
    await notificationController.getData();

    await wsMainController.getData();
    await statusesController.getData();
    await tasksMainController.getData();

    _setUpdateDate(now);
    await loader.stop();
  }

  Future _explainUpdateDetails() async {
    if (tasksMainController.hasLinkedProjects && !accountController.updateDetailsExplanationViewed) {
      await showMTAlertDialog(
        loc.explain_update_details_dialog_title,
        description: loc.explain_update_details_dialog_description,
        actions: [MTADialogAction(title: loc.ok, type: MTActionType.isDefault, result: true)],
        simple: true,
      );
      await accountController.setUpdateDetailsExplanationViewed();
    }
  }

  // Future _showWelcomeGiftInfo() async {
  //   if (wsMainController.myWSs.isNotEmpty) {
  //     // TODO: берем первый попавшийся. Нужно изменить триггер для показа инфы о приветственном балансе
  //     final myWS = wsMainController.myWSs.first;
  //     final wga = myWS.welcomeGiftAmount;
  //     final wsId = myWS.id;
  //     if (wga > 0 && !accountController.welcomeGiftInfoViewed(wsId!)) {
  //       final wantChangeTariff = await showMTAlertDialog(
  //         loc.onboarding_welcome_gift_dialog_title,
  //         description: loc.onboarding_welcome_gift_dialog_description(wga.currency),
  //         actions: [
  //           MTADialogAction(title: loc.tariff_change_action_title, type: MTActionType.isDefault, result: true),
  //           MTADialogAction(title: loc.later, result: false),
  //         ],
  //       );
  //       await accountController.setWelcomeGiftInfoViewed(wsId);
  //
  //       if (wantChangeTariff == true) {
  //         await myWS.changeTariff();
  //       }
  //     }
  //   }
  // }

  // Future _showOnboarding() async {
  // await _showWelcomeGiftInfo();
  // }

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
      loader.set(imageName: 'purchase', titleText: loc.loader_purchasing_title);
      await wsMainController.getData();
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
            for (final ws in wsMainController.myWSs) {
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
    // await _showOnboarding();
    if (isIOS) {
      await notificationController.initPush();
    }
  }

  // TODO: пригодится блокировка от возможного повторного запуска в том же потоке
  Future startupActions() async {
    await serviceSettingsController.getSettings();
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

  void clearData() {
    wsMainController.clearData();
    tasksMainController.clearData();
    statusesController.clearData();

    _setUpdateDate(null);

    refsController.clearData();
    accountController.clearData();
    notificationController.clearData();
    localSettingsController.clearData();
  }
}
