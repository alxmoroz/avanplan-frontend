// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/button.dart';
import '../../../../components/colors.dart';
import '../../../../components/constants.dart';
import '../../../../components/icons.dart';
import '../../../../components/icons_workspace.dart';
import '../../../../components/list_tile.dart';
import '../../../../components/text.dart';
import '../../../../extra/services.dart';
import '../../../../usecases/task_tree.dart';
import '../../../../usecases/ws_actions.dart';
import '../../../../usecases/ws_tariff.dart';
import 'invitation_dialog.dart';

class InvitationButton extends StatelessWidget {
  const InvitationButton(this.task, {this.inList = false, this.type = ButtonType.main});
  final Task task;
  final bool inList;
  final ButtonType type;

  bool get _hasLimit => !task.ws.plUsers;

  static Future onTap(Task task) async {
    if (task.ws.plUsers) {
      await invitationDialog(task);
    } else {
      await task.ws.changeTariff(reason: loc.tariff_change_limit_users_reason_title);
    }
  }

  @override
  Widget build(BuildContext context) {
    return inList
        ? MTListTile(
            leading: const MemberAddIcon(size: P8),
            middle: BaseText(loc.invitation_create_title, color: mainColor),
            trailing: _hasLimit ? const RoubleCircleIcon(size: P6) : null,
            bottomDivider: false,
            onTap: () => onTap(task),
          )
        : MTBadgeButton(
            showBadge: _hasLimit,
            type: type,
            leading: MemberAddIcon(color: type == ButtonType.main ? mainBtnTitleColor : null),
            titleText: loc.invitation_create_title,
            onTap: () => onTap(task),
          );
  }
}
