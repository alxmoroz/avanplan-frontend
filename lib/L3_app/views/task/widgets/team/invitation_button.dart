// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/button.dart';
import '../../../../components/colors.dart';
import '../../../../components/constants.dart';
import '../../../../components/icons.dart';
import '../../../../components/list_tile.dart';
import '../../../../components/text.dart';
import '../../../../extra/services.dart';
import 'invitation_dialog.dart';

class InvitationButton extends StatelessWidget {
  const InvitationButton(this.task, {super.key, this.inList = false, this.type = ButtonType.main});
  final Task task;
  final bool inList;
  final ButtonType type;

  @override
  Widget build(BuildContext context) {
    return inList
        ? MTListTile(
            leading: const MemberAddIcon(size: P8),
            middle: BaseText(loc.invitation_create_title, color: mainColor, maxLines: 1),
            bottomDivider: false,
            onTap: () => invite(task),
          )
        : MTButton(
            type: type,
            constrained: true,
            leading: MemberAddIcon(color: type == ButtonType.main ? mainBtnTitleColor : mainColor),
            titleText: loc.invitation_create_title,
            onTap: () => invite(task),
          );
  }
}
