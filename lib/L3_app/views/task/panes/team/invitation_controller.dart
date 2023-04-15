// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobx/mobx.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../../L1_domain/entities/invitation.dart';
import '../../../../../../L1_domain/entities/role.dart';
import '../../../../../../L1_domain/entities/task.dart';
import '../../../../../L2_data/services/platform.dart';
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

    initState(tfaList: [
      TFAnnotation('expiresOn', label: loc.invitation_expires_placeholder, noText: true),
      TFAnnotation('activationsCount', label: loc.invitation_activations_count_placeholder, text: '10'),
    ]);

    setExpired(DateTime.now().add(const Duration(days: 7)));
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

  Future selectDate(BuildContext context) async {
    final today = DateTime.now();
    final lastDate = today.add(const Duration(days: 7));
    final initialDate = expiresOn ?? today;
    final firstDate = today;

    final date = await showDatePicker(
      context: context,
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
  String invitationUrl = '';

  @action
  Future createInvitation() async {
    final activationsCount = int.tryParse(tfAnnoForCode('activationsCount').text) ?? 0;
    if (activationsCount > 0) {
      loaderController.start();
      loaderController.setCreateInvitation();
      invitationUrl = await invitationUC.create(
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

  String get invitationSubject => '${loc.invitation_share_subject_prefix}${loc.app_title} - ${task.title}';

  Future shareInvitation(BuildContext context) async {
    if (invitationUrl.isEmpty) {
      await createInvitation();
    }

    if (!isWeb) {
      final box = context.findRenderObject() as RenderBox?;
      await Share.shareWithResult(
        invitationUrl,
        subject: invitationSubject,
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
      );
    }
  }

  void copyUrl(BuildContext context) {
    Clipboard.setData(ClipboardData(text: invitationUrl));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: NormalText(loc.copied_notification_title, align: TextAlign.center),
        backgroundColor: darkBackgroundColor.resolve(context),
        duration: const Duration(milliseconds: 1234),
      ),
    );
  }
}
