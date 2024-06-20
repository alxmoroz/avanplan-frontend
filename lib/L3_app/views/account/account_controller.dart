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

class AccountController extends _AccountControllerBase with _$AccountController {}

abstract class _AccountControllerBase extends EditController with Store, Loadable {
  @observable
  User? me;

  @computed
  Map<String, Iterable<UActivity>> get _activitiesMap => groupBy<UActivity, String>(me?.activities ?? [], (a) => a.code);

  @action
  Future reload() async {
    // вызывается из mainController с его лоадером
    me = await myUC.getAccount();
    stopLoading();
  }

  @action
  Future registerActivity(String code, {int? wsId}) async => me = await myUC.registerActivity(code, wsId: wsId);

  bool hasActivity(String code, {int? wsId}) => _activitiesMap[code]?.where((a) => a.wsId == wsId).isNotEmpty == true;

  @action
  void clear() => me = null;

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
}
