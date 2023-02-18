// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../L1_domain/entities/invitation.dart';
import '../../../../L1_domain/entities/role.dart';
import '../../../../L1_domain/entities/task.dart';
import '../../components/text_field_annotation.dart';
import '../../extra/services.dart';
import '../../presenters/date_presenter.dart';
import '../_base/edit_controller.dart';

part 'invitation_controller.g.dart';

class InvitationController extends _InvitationControllerBase with _$InvitationController {
  InvitationController(Task _task, Role _role) {
    task = _task;
    role = _role;

    initState(tfaList: [
      TFAnnotation('activeDate', label: loc.invitation_active_until_placeholder, noText: true),
      TFAnnotation('activationsCount', label: loc.invitation_activations_count_placeholder, text: '10'),
    ]);

    setActiveDate(DateTime.now().add(const Duration(days: 7)));
  }
}

abstract class _InvitationControllerBase extends EditController with Store {
  late final Task task;
  late final Role role;

  @observable
  DateTime? activeDate;

  @action
  void setActiveDate(DateTime? _date) {
    activeDate = _date;
    teControllers['activeDate']?.text = _date != null ? _date.strLong : '';
  }

  Future selectDate(BuildContext context) async {
    final today = DateTime.now();
    final lastDate = today.add(const Duration(days: 7));
    final initialDate = activeDate ?? today;
    final firstDate = today;

    final date = await showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    if (date != null) {
      setActiveDate(date);
    }
  }

  /// приглашение

  @observable
  String invitationUrl = '';

  @action
  Future createInvitation() async {
    final activationsCount = int.tryParse(tfAnnoForCode('activationsCount').text) ?? 0;
    if (activationsCount > 0) {
      invitationUrl = await invitationUC.create(
          Invitation(
            task.id!,
            role.id!,
            activationsCount,
            activeDate!,
          ),
          task.wsId);
    }
  }

  String get invitationSubject => '${loc.invitation_share_subject_prefix}${loc.app_title} - ${task.title}';
}
