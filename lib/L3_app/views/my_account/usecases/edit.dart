// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../components/alert_dialog.dart';
import '../../../components/button.dart';
import '../../../components/images.dart';
import '../../app/services.dart';
import '../my_account_controller.dart';

extension AccountEditUC on MyAccountController {
  Future delete(BuildContext context) async {
    if ((await showMTAlertDialog(
          imageName: ImageName.delete.name,
          title: loc.my_account_delete_dialog_title,
          description: loc.my_account_delete_dialog_description,
          actions: [
            MTDialogAction(title: loc.action_yes_delete_title, type: MTButtonType.danger, result: true),
            MTDialogAction(title: loc.action_no_dont_delete_title, result: false),
          ],
        )) ==
        true) {
      setLoaderScreenDeleting();
      await load(() async {
        await myUC.deleteAccount();
        await authController.signOut(disconnect: true);
      });
    }
  }
}
