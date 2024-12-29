// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/button.dart';
import '../../../../components/constants.dart';
import '../../../../components/icons.dart';
import '../../../app/services.dart';
import 'invitation_dialog.dart';

class InvitationButton extends StatelessWidget {
  const InvitationButton(this._task, {super.key});
  final Task _task;

  @override
  Widget build(BuildContext context) {
    return MTButton.secondary(
      constrained: true,
      leading: const MemberAddIcon(),
      margin: const EdgeInsets.only(top: P3),
      titleText: loc.invitation_create_title,
      onTap: () => invite(_task),
    );
  }
}
