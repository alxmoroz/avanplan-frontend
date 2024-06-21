// Copyright (c) 2024. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/user.dart';
import '../../../L1_domain/entities/user_activity.dart';
import '../../components/alert_dialog.dart';
import '../../extra/services.dart';
import '../_base/edit_controller.dart';
import '../_base/loadable.dart';

part 'account_controller.g.dart';

class AccountController extends _AccountControllerBase with _$AccountController {
  Future delete(BuildContext context) async {
    final confirm = await showMTAlertDialog(
      loc.my_account_delete_dialog_title,
      description: loc.my_account_delete_dialog_description,
      actions: [
        MTADialogAction(title: loc.yes, type: MTDialogActionType.danger, result: true),
        MTADialogAction(title: loc.no, type: MTDialogActionType.isDefault, result: false),
      ],
      simple: true,
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

  Future registerOnboardingPassed(int stepIndex) async {
    await registerActivity('${UACode.ONBOARDING_PASSED}_${stepIndex + 1}');
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
}
