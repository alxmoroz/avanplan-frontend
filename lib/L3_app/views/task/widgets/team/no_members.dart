// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/constants.dart';
import '../../../../components/images.dart';
import '../../../../components/text.dart';
import '../../../../extra/services.dart';
import '../../../../usecases/task_actions.dart';
import 'invitation_button.dart';

class NoMembers extends StatelessWidget {
  const NoMembers(this._task, {super.key});
  final Task _task;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        MTImage(ImageName.empty_team.name),
        const SizedBox(height: P2),
        H2(loc.team_empty_title, align: TextAlign.center),
        const SizedBox(height: P),
        BaseText(loc.team_empty_hint, align: TextAlign.center),
        if (_task.canInviteMembers) ...[
          const SizedBox(height: P3),
          InvitationButton(_task),
        ]
      ],
    );
  }
}
