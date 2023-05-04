// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobx/mobx.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../L1_domain/entities/invitation.dart';
import '../../../../../L1_domain/entities/role.dart';
import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L2_data/services/platform.dart';
import '../../../../../main.dart';
import '../../../../components/colors.dart';
import '../../../../components/text_field_annotation.dart';
import '../../../../components/text_widgets.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/date_presenter.dart';
import '../../../_base/edit_controller.dart';

part 'invitation_controller.g.dart';

class InvitationController extends _InvitationControllerBase with _$InvitationController {
  InvitationController(Task _task, Role _role) {
    task = _task;
    role = _role;
  }
}

abstract class _InvitationControllerBase extends EditController with Store {
  late final Task task;
  late final Role role;

  @observable
  DateTime? expiresOn;

  @action
  void setExpired(DateTime? _date) {
    expiresOn = _date;
    teControllers['expiresOn']?.text = _date != null ? _date.strMedium : '';
  }

  Future selectDate() async {
    final today = DateTime.now();
    final lastDate = today.add(const Duration(days: 7));
    final initialDate = expiresOn ?? today;
    final firstDate = today;

    final date = await showDatePicker(
      context: rootKey.currentContext!,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    if (date != null) {
      setExpired(date);
    }
  }

  /// приглашение
  @observable
  Invitation? invitation;

  @computed
  String get invitationUrl => invitation?.url ?? '';

  @action
  Future createInvitation() async {
    final activationsCount = int.tryParse(tfAnnoForCode('activationsCount').text) ?? 0;
    if (activationsCount > 0) {
      loaderController.start();
      loaderController.setCreateInvitation();
      invitation = await invitationUC.create(
          Invitation(
            task.id!,
            role.id!,
            activationsCount,
            expiresOn!,
          ),
          task.wsId);
      await loaderController.stop();
    }
  }

  @action
  Future fetchInvitation() async {
    loaderController.start();
    loaderController.setRefreshing();
    invitation = await invitationUC.getInvitation(task.wsId, task.id!, role.id!);

    initState(tfaList: [
      TFAnnotation('expiresOn', label: loc.invitation_expires_placeholder, noText: true),
      TFAnnotation('activationsCount', label: loc.invitation_activations_count_placeholder, text: '${invitation?.activationsCount ?? '10'}'),
    ]);

    setExpired(invitation?.expiresOn ?? DateTime.now().add(const Duration(days: 7)));

    await loaderController.stop();
  }

  String get invitationSubject => '${loc.invitation_share_subject_prefix}${loc.app_title} - ${task.title}';
  String get invitationText => loc.invitation_share_text('https://moroz.team/avanplan/install', invitationUrl);

  Future shareInvitation(BuildContext context) async {
    FocusScope.of(context).unfocus();
    if (invitationUrl.isEmpty) {
      await createInvitation();
    }

    if (!isWeb) {
      final box = context.findRenderObject() as RenderBox?;
      await Share.shareWithResult(
        invitationText,
        subject: invitationSubject,
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
      );
    }
  }

  void copyInvitation(BuildContext context) {
    Clipboard.setData(ClipboardData(text: invitationText));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: NormalText(loc.copied_notification_title, align: TextAlign.center),
        backgroundColor: darkBackgroundColor.resolve(context),
        duration: const Duration(milliseconds: 1234),
      ),
    );
  }
}
