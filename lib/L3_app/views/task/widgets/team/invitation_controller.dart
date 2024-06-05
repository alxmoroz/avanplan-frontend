// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobx/mobx.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../L1_domain/entities/invitation.dart';
import '../../../../../L1_domain/entities/role.dart';
import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/utils/dates.dart';
import '../../../../../L2_data/services/platform.dart';
import '../../../../components/colors.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/text.dart';
import '../../../../extra/services.dart';
import '../../../../usecases/task_tree.dart';

part 'invitation_controller.g.dart';

enum InvitationFCode { expiresOn, activationsCount }

class InvitationController extends _InvitationControllerBase with _$InvitationController {
  InvitationController(Task taskIn) {
    task = taskIn;
  }
}

abstract class _InvitationControllerBase with Store {
  late final Task task;

  Iterable<Role> get roles => task.ws.roles;

  /// Роль
  @observable
  Role? role;
  @computed
  bool get roleSelected => role != null;

  @action
  Future inviteRole(Role roleIn, BuildContext context) async {
    role = roleIn;
    invitation = null;
    invitation = await invitationUC.getInvitation(
          task.wsId,
          task.id!,
          role!.id!,
        ) ??
        await invitationUC.create(
            Invitation(
              task.id!,
              role!.id!,
              5,
              nextWeek,
            ),
            task.wsId);

    if (context.mounted && hasUrl) {
      if (isWeb) {
        copy(context);
      } else {
        Navigator.of(context).pop();
        await _share(context);
      }
    }
  }

  /// приглашение
  @observable
  Invitation? invitation;
  @computed
  String get _url => invitation?.url ?? '';
  @computed
  bool get hasUrl => _url.isNotEmpty;

  String get _invitationSubject => '${loc.invitation_share_subject_prefix}${loc.app_title} - $task';
  String get invitationText => '$_invitationSubject\n\n${loc.invitation_share_text('https://moroz.team/avanplan/install', _url)}';

  Future _share(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;
    await Share.share(
      invitationText,
      subject: _invitationSubject,
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );
  }

  void copy(BuildContext context) {
    Clipboard.setData(ClipboardData(text: invitationText));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: BaseText(loc.copied_notification_title, align: TextAlign.center),
        backgroundColor: b2Color.resolve(context),
        duration: const Duration(milliseconds: 1234),
      ),
    );
  }
}
