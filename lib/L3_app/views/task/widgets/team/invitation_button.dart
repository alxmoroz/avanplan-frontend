// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/adaptive.dart';
import '../../../../components/button.dart';
import '../../../../components/colors.dart';
import '../../../../components/icons_workspace.dart';
import '../../../../components/limit_badge.dart';
import '../../../../extra/services.dart';
import '../../../../usecases/ws_actions.dart';
import '../../../../usecases/ws_tariff.dart';
import 'invitation_dialog.dart';

class InvitationButton extends StatelessWidget {
  const InvitationButton(this.task, {this.type});
  final Task task;
  final ButtonType? type;

  @override
  Widget build(BuildContext context) {
    final _type = type ?? ButtonType.main;

    return MTAdaptive.xs(
      child: MTLimitBadge(
        showBadge: !task.ws.plUsers,
        child: MTButton(
          type: _type,
          leading: MemberAddIcon(color: _type == ButtonType.main ? mainBtnTitleColor : mainColor),
          titleText: loc.invitation_create_title,
          constrained: false,
          onTap: task.ws.plUsers ? () => invitationDialog(task) : () => task.ws.changeTariff(reason: loc.tariff_change_limit_users_reason_title),
        ),
      ),
    );
  }
}
