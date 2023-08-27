// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/user.dart';
import '../../../L1_domain/entities/user_activity.dart';
import '../../components/alert_dialog.dart';
import '../../extra/services.dart';
import '../_base/edit_controller.dart';

part 'account_controller.g.dart';

class AccountController extends _AccountControllerBase with _$AccountController {}

abstract class _AccountControllerBase extends EditController with Store {
  @observable
  User? user;

  @computed
  Map<String, Iterable<UActivity>> get _activitiesMap => groupBy<UActivity, String>(user?.activities ?? [], (a) => a.code);

  @action
  Future fetchData() async => user = await myUC.getAccount();

  @action
  Future _registerActivity(String code, {int? wsId}) async {
    loader.start();
    loader.setLoading();
    user = await myUC.registerActivity(code, wsId: wsId);
    await loader.stop();
  }

  bool _hasActivity(String code, {int? wsId}) => _activitiesMap[code]?.where((a) => a.wsId == wsId).isNotEmpty == true;

  @action
  Future setUpdateDetailsExplanationViewed() async => await _registerActivity(UACode.UPDATE_DETAILS_EXPLANATION_VIEWED);
  @computed
  bool get updateDetailsExplanationViewed => _hasActivity(UACode.UPDATE_DETAILS_EXPLANATION_VIEWED);

  @action
  Future setWelcomeGiftInfoViewed(int wsId) async => await _registerActivity(UACode.WELCOME_GIFT_INFO_VIEWED, wsId: wsId);
  bool welcomeGiftInfoViewed(int wsId) => _hasActivity(UACode.WELCOME_GIFT_INFO_VIEWED, wsId: wsId);

  @action
  void clearData() => user = null;

  Future delete() async {
    final confirm = await showMTAlertDialog(
      loc.account_delete_dialog_title,
      description: loc.account_delete_dialog_description,
      actions: [
        MTADialogAction(title: loc.yes, type: MTActionType.isDanger, result: true),
        MTADialogAction(title: loc.no, type: MTActionType.isDefault, result: false),
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
