// Copyright (c) 2023. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../L1_domain/entities/invitation.dart';
import '../../../../L1_domain/entities/member.dart';
import '../../../../L1_domain/entities/role.dart';
import '../../../../L1_domain/entities/task.dart';
import '../../../extra/services.dart';
import '../../../presenters/date_presenter.dart';
import '../../_base/edit_controller.dart';

part 'tmr_edit_controller.g.dart';

enum MemberSourceKey { workspace, invitation }

class TMREditController extends _TMREditControllerBase with _$TMREditController {
  TMREditController(Task _task) {
    task = _task;
  }
}

abstract class _TMREditControllerBase extends EditController with Store {
  late final Task task;
  final tabKeys = [
    MemberSourceKey.workspace,
    MemberSourceKey.invitation,
  ];

  @observable
  MemberSourceKey? _tabKey;

  @action
  void selectTab(MemberSourceKey? tk) => _tabKey = tk;

  @computed
  MemberSourceKey get tabKey => (tabKeys.contains(_tabKey) ? _tabKey : null) ?? MemberSourceKey.invitation;

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

  /// действия
  // Future<TaskMemberRole?> _saveTMR(int? id, int wsId, int taskId, int memberId, int roleId) async => await tmrUC.save(
  //       TaskMemberRole(
  //         id: id,
  //         wsId: wsId,
  //         taskId: taskId,
  //         memberId: memberId,
  //         roleId: roleId,
  //       ),
  //     );
  //
  // Future save(
  //   BuildContext context, {
  //   required int wsId,
  //   required int taskId,
  //   required int memberId,
  //   required int roleId,
  //   bool proceed = false,
  // }) async {
  //   loaderController.start();
  //   loaderController.setSaving();
  //   final editedTMR = await _saveTMR(wsId, taskId, memberId, roleId);
  //   if (editedTMR != null) {
  //     Navigator.of(context).pop(EditTMRResult(editedTMR, proceed));
  //   }
  //   await loaderController.stop(300);
  // }
  //

  // Future delete(BuildContext context, TaskMemberRole tmr) async {
  //   final confirm = await showMTDialog<bool?>(
  //     context,
  //     title: tmr.deleteDialogTitle,
  //     description: '${loc.tmr_delete_dialog_description}\n${loc.delete_dialog_description}',
  //     actions: [
  //       MTDialogAction(title: loc.yes, type: MTActionType.isDanger, result: true),
  //       MTDialogAction(title: loc.no, type: MTActionType.isDefault, result: false),
  //     ],
  //     simple: true,
  //   );
  //   if (confirm == true) {
  //     loaderController.start();
  //     loaderController.setDeleting();
  //     final deletedTMR = await tmrUC.delete(tmr);
  //     Navigator.of(context).pop(EditTMRResult(deletedTMR));
  //     await loaderController.stop(300);
  //   }
  // }

  /// участники
  @observable
  List<Member> allowedMembers = [];

  @action
  void setAllowedMembers(List<Member> members) => allowedMembers = members;

  @observable
  Member? member;

  @action
  void selectMember(Member? m) => member = m;
  void selectMemberById(int? id) => selectMember(allowedMembers.firstWhereOrNull((m) => m.id == id));

  /// роли
  @observable
  Iterable<Role> allowedRoles = [];

  @action
  void setAllowedRoles(Iterable<Role> roles) => allowedRoles = roles;

  @observable
  Role? role;

  @action
  void selectRole(Role? r) => role = r;
  void selectRoleById(int? id) => selectRole(allowedRoles.firstWhereOrNull((r) => r.id == id));

  /// приглашение

  @observable
  String invitationUrl = '';

  @override
  bool get validated => super.validated && role != null;

  @action
  Future createInvitation() async {
    final activationsCount = int.tryParse(tfAnnoForCode('activationsCount').text) ?? 0;
    if (activationsCount > 0) {
      invitationUrl = await invitationUC.create(
          Invitation(
            task.id!,
            role!.id!,
            activationsCount,
            activeDate!,
          ),
          task.wsId);
    }
  }
}
