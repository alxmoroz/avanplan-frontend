// Copyright (c) 2023. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../L1_domain/entities/member.dart';
import '../../../../L1_domain/entities/role.dart';
import '../../../presenters/date_presenter.dart';
import '../../_base/edit_controller.dart';

part 'tmr_edit_controller.g.dart';

enum MemberSourceTabKey { workspace, external }

class TMREditController = _TMREditControllerBase with _$TMREditController;

abstract class _TMREditControllerBase extends EditController with Store {
  @computed
  Iterable<MemberSourceTabKey> get tabKeys {
    return [
      MemberSourceTabKey.workspace,
      MemberSourceTabKey.external,
    ];
  }

  @observable
  MemberSourceTabKey? _tabKey;

  @action
  void selectTab(MemberSourceTabKey? tk) => _tabKey = tk;

  @computed
  MemberSourceTabKey get tabKey => (tabKeys.contains(_tabKey) ? _tabKey : null) ?? (tabKeys.isNotEmpty ? tabKeys.first : MemberSourceTabKey.external);

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

  // @override
  // bool get validated => super.validated;

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
  void setAllowedMembers(List<Member> assignees) => allowedMembers = assignees;

  @observable
  Member? selectedMember;

  @action
  void selectMember(Member? m) => selectedMember = m;
  void selectMemberById(int? id) => selectMember(allowedMembers.firstWhereOrNull((m) => m.id == id));

  /// роли
  @observable
  List<Role> allowedRoles = [];

  @action
  void setAllowedRoles(List<Role> roles) => allowedRoles = roles;

  @observable
  Role? selectedRole;

  @action
  void selectRole(Role? r) => selectedRole = r;
  void selectRoleById(int? id) => selectRole(allowedRoles.firstWhereOrNull((r) => r.id == id));
}
