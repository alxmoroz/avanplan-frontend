// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/user.dart';
import '../../components/mt_dialog.dart';
import '../../extra/services.dart';
import '../_base/edit_controller.dart';

part 'account_controller.g.dart';

class AccountController extends _AccountControllerBase with _$AccountController {}

abstract class _AccountControllerBase extends EditController with Store {
  @observable
  User? user;

  @action
  Future fetchData() async => user = await myUC.getMyAccount();

  @action
  void clearData() => user = null;

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
      loaderController.start();
      loaderController.setDeleting();

      await myUC.deleteMyAccount();
      await authController.signOut();

      await loaderController.stop();
    }
  }
}
