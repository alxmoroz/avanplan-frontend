// Copyright (c) 2024. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/user.dart';
import '../../../L1_domain/entities/user_activity.dart';
import '../../components/alert_dialog.dart';
import '../../components/button.dart';
import '../../extra/services.dart';
import '../_base/edit_controller.dart';
import '../_base/loadable.dart';

part 'account_controller.g.dart';

class AccountController extends _AccountControllerBase with _$AccountController {
  Future delete(BuildContext context) async {
    final confirm = await showMTAlertDialog(
      title: loc.my_account_delete_dialog_title,
      description: loc.my_account_delete_dialog_description,
      actions: [
        MTDialogAction(title: loc.action_yes_delete_title, type: ButtonType.danger, result: true),
        MTDialogAction(title: loc.action_no_delete_title, result: false),
      ],
    );
    if (confirm == true) {
      setLoaderScreenDeleting();
      await load(() async {
        await myUC.deleteAccount();
        await authController.signOut();
      });
    }
  }

  Future registerPromoFeaturesViewed() async {
    await registerActivity(UACode.PROMO_FEATURES_VIEWED);
  }

  Future registerOnboardingPassed(String stepCode) async {
    await registerActivity('${UACode.ONBOARDING_PASSED}_$stepCode');
  }
}

abstract class _AccountControllerBase extends EditController with Store, Loadable {
  @observable
  User? me;

  @computed
  Map<String, Iterable<UActivity>> get _activitiesMap => groupBy<UActivity, String>(me?.activities ?? [], (a) => a.code);

  @computed
  bool get onboardingPassed => me?.activities.where((a) => a.code.startsWith(UACode.ONBOARDING_PASSED)).isNotEmpty == true;

  @computed
  bool get promoFeaturesViewed => me?.activities.where((a) => a.code.startsWith(UACode.PROMO_FEATURES_VIEWED)).isNotEmpty == true;

  @action
  Future reload() async {
    // вызывается из mainController с его лоадером
    me = await myUC.getAccount();
    stopLoading();
  }

  @action
  Future registerActivity(String code, {int? wsId}) async => me = await myUC.registerActivity(code, wsId: wsId);

  @action
  void clear() => me = null;

  @action
  Future uploadAvatar(XFile file) async {
    setLoaderScreenSaving();
    await load(() async {
      me = await myAvatarUC.uploadAvatar(
        file.openRead,
        await file.length(),
        file.name,
        await file.lastModified(),
      );
    });
    wsMainController.reload();
  }

  @action
  Future deleteAvatar() async {
    setLoaderScreenSaving();
    await load(() async {
      me = await myAvatarUC.deleteAvatar();
    });
    wsMainController.reload();
  }
}
