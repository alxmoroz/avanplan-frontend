// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/user.dart';
import '../../../L1_domain/entities/user_activity.dart';
import '../../components/mt_dialog.dart';
import '../../extra/services.dart';
import '../_base/edit_controller.dart';

part 'account_controller.g.dart';

class AccountController extends _AccountControllerBase with _$AccountController {}

abstract class _AccountControllerBase extends EditController with Store {
  @observable
  User? user;

  @observable
  Iterable<UActivity> activities = [];

  @computed
  Map<String, Iterable<UActivity>> get _activitiesMap => groupBy<UActivity, String>(activities, (a) => a.code);

  @action
  Future _fetchActivities() async {
    if (user != null) {
      final _activities = <UActivity>[];
      for (final code in [
        UACode.UPDATE_DETAILS_EXPLANATION_VIEWED,
        UACode.WELCOME_GIFT_INFO_VIEWED,
      ]) {
        _activities.addAll(await myUC.getActivities(code));
      }
      activities = _activities;
    }
  }

  @action
  Future fetchData() async {
    user = await myUC.getAccount();
    _fetchActivities();
  }

  @action
  Future _registerActivity(String code, {int? wsId}) async {
    loader.start();
    loader.setRefreshing();
    activities = await myUC.registerActivity(code, wsId: wsId);
    await loader.stop();
  }

  bool hasActivity(String code, {int? wsId}) => _activitiesMap[code]?.where((a) => a.wsId == wsId).isNotEmpty == true;

  @action
  Future setUpdateDetailsExplanationViewed() async => await _registerActivity(UACode.UPDATE_DETAILS_EXPLANATION_VIEWED);
  @computed
  bool get updateDetailsExplanationViewed => hasActivity(UACode.UPDATE_DETAILS_EXPLANATION_VIEWED);

  @action
  Future setWelcomeGiftInfoViewed(int wsId) async => await _registerActivity(UACode.WELCOME_GIFT_INFO_VIEWED, wsId: wsId);
  bool welcomeGiftInfoViewed(int wsId) => hasActivity(UACode.WELCOME_GIFT_INFO_VIEWED, wsId: wsId);

  @action
  void clearData() {
    user = null;
    activities = [];
  }

  Future delete(BuildContext context) async {
    final confirm = await showMTDialog(
      context,
      title: loc.account_delete_dialog_title,
      description: loc.account_delete_dialog_description,
      actions: [
        MTDialogAction(title: loc.yes, type: MTActionType.isDanger, result: true),
        MTDialogAction(title: loc.no, type: MTActionType.isDefault, result: false),
      ],
      simple: true,
    );
    if (confirm == true) {
      loader.start();
      loader.setDeleting();

      await myUC.deleteAccount();
      await authController.signOut();

      await loader.stop();
    }
  }
}
