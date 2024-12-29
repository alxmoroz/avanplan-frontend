// Copyright (c) 2024. Alexandr Moroz

import '../../../../components/alert_dialog.dart';
import '../../../../components/button.dart';
import '../../../../components/images.dart';
import '../../../app/services.dart';

Future<bool> get confirmTransferAndUnlinkRelations async =>
    await showMTAlertDialog(
        imageName: ImageName.delete.name,
        title: loc.transfer_unlink_relations_dialog_title,
        description: loc.transfer_unlink_relations_dialog_hint,
        actions: [
          MTDialogAction(result: true, title: loc.action_yes_transfer_unlink_title, type: MTButtonType.danger),
          MTDialogAction(result: false, title: loc.action_no_dont_transfer_title),
        ]) ==
    true;
