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
import '../../../../../main.dart';
import '../../../../components/colors.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/field_data.dart';
import '../../../../components/icons.dart';
import '../../../../components/images.dart';
import '../../../../components/text.dart';
import '../../../../components/text_field.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/date.dart';
import '../../../_base/edit_controller.dart';

part 'invitation_controller.g.dart';

enum InvitationFCode { expiresOn, activationsCount }

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
    teController(InvitationFCode.expiresOn.index)?.text = _date != null ? _date.strMedium : '';
  }

  Future selectDate() async {
    final lastDate = nextWeek;
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
    final activationsCount = int.tryParse(fData(InvitationFCode.activationsCount.index).text) ?? 0;
    if (activationsCount > 0) {
      loader.start();
      loader.set(titleText: loc.loader_invitation_create_title, imageName: ImageNames.privacy);
      invitation = await invitationUC.create(
          Invitation(
            task.id!,
            role.id!,
            activationsCount,
            expiresOn!,
          ),
          task.ws.id!);
      await loader.stop();
    }
  }

  @action
  Future fetchInvitation() async {
    loader.start();
    loader.setLoading();
    invitation = await invitationUC.getInvitation(task.ws.id!, task.id!, role.id!);

    initState(fds: [
      MTFieldData(InvitationFCode.expiresOn.index, label: loc.invitation_expires_placeholder, noText: true, validate: true),
      MTFieldData(
        InvitationFCode.activationsCount.index,
        label: loc.invitation_activations_count_placeholder,
        text: '${invitation?.activationsCount ?? '10'}',
        validate: true,
      ),
    ]);

    setExpired(invitation?.expiresOn ?? DateTime.now().add(const Duration(days: 7)));

    await loader.stop();
  }

  String get invitationSubject => '${loc.invitation_share_subject_prefix}${loc.app_title} - $task';
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
        backgroundColor: b2Color.resolve(context),
        duration: const Duration(milliseconds: 1234),
      ),
    );
  }

  // TODO: редактор даты как в задачах?
  Widget tf(InvitationFCode code) {
    final fd = fData(code.index);
    final isDate = code == InvitationFCode.expiresOn;
    final tc = teController(code.index);
    return fd.noText
        ? MTTextField.noText(
            controller: tc,
            label: fd.label,
            error: fd.errorText,
            onTap: isDate ? selectDate : null,
            prefixIcon: isDate ? const CalendarIcon() : null,
          )
        : MTTextField(
            autofocus: false,
            controller: tc,
            label: fd.label,
            error: fd.errorText,
            keyboardType: code == InvitationFCode.activationsCount ? TextInputType.number : null,
          );
  }
}
