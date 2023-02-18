// Copyright (c) 2023. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../_base/edit_controller.dart';

part 'member_add_controller.g.dart';

enum MemberSourceKey { workspace, invitation }

class MemberAddController extends _MemberAddControllerBase with _$MemberAddController {
  // MemberAddController() {}
}

abstract class _MemberAddControllerBase extends EditController with Store {
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
}
