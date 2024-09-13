// Copyright (c) 2024. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/member.dart';
import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities_extensions/task_members.dart';
import '../../../../components/alert_dialog.dart';
import '../../../../components/avatar.dart';
import '../../../../components/button.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/dialog.dart';
import '../../../../components/icons.dart';
import '../../../../components/images.dart';
import '../../../../components/list_tile.dart';
import '../../../../components/refresh.dart';
import '../../../../components/select_dialog.dart';
import '../../../../components/text.dart';
import '../../../../components/toolbar.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/person.dart';
import '../../../../presenters/task_actions.dart';
import '../../../../presenters/task_tree.dart';
import '../../../../presenters/ws_member.dart';
import '../../../_base/loader_screen.dart';
import '../../controllers/task_controller.dart';
import '../../usecases/members.dart';
import '../tasks/task_card.dart';
import 'member_tasks_controller.dart';

Future taskMemberDialog(TaskController taskController, int memberId) async {
  final mtc = MemberTasksController(taskController.task.wsId, memberId);
  return await showMTDialog<void>(_MemberDialog(taskController, memberId, mtc));
}

class _MemberDialog extends StatelessWidget {
  const _MemberDialog(this._tc, this._memberId, this._mTasksController);
  final TaskController _tc;
  final MemberTasksController _mTasksController;
  final int _memberId;

  Task get _project => _tc.task;
  WSMember? get _member => _project.memberForId(_memberId);

  Future _editRoles(BuildContext context) async {
    final roles = _project.ws.roles.toList();
    final selectedId = roles.firstWhereOrNull((r) => _member?.roles.contains(r.code) == true)?.id;
    final selectedRole = await showMTSelectDialog(
      roles,
      selectedId,
      loc.role_title,
      parentPageTitle: _member?.fullName,
      valueBuilder: (_, r) => BaseText(r.title, maxLines: 1),
      subtitleBuilder: (_, r) => r.description.isNotEmpty ? SmallText(r.description, maxLines: 1) : const SizedBox(),
    );
    if (selectedRole != null) {
      await _tc.assignMemberRoles(_memberId, [selectedRole.id!]);
    }
  }

  Future _unlinkMember(BuildContext context) async {
    final confirm = await showMTAlertDialog(
      imageName: ImageName.privacy.name,
      title: loc.member_unlink_dialog_title,
      description: loc.member_unlink_dialog_description,
      actions: [
        MTDialogAction(title: loc.action_unlink_title, type: ButtonType.danger, result: true),
        MTDialogAction(title: loc.action_no_dont_unlink_title, result: false),
      ],
    );

    if (confirm == true) {
      if (context.mounted) Navigator.of(context).pop();
      await _tc.assignMemberRoles(_memberId, []);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => _mTasksController.loading
          ? LoaderScreen(_mTasksController, isDialog: true)
          : MTDialog(
              topBar: MTAppBar(
                showCloseButton: true,
                color: b2Color,
                parentPageTitle: _project.title,
                pageTitle: loc.member_title,
              ),
              body: _member != null
                  ? MTRefresh(
                      onRefresh: _mTasksController.reload,
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          const SizedBox(height: P3),
                          _member!.icon(MAX_AVATAR_RADIUS),
                          const SizedBox(height: P3),
                          H3('$_member', align: TextAlign.center),
                          BaseText(_member!.email, align: TextAlign.center, maxLines: 1),
                          if (_mTasksController.hasAssignedTasks) ...[
                            MTListGroupTitle(titleText: loc.task_assignee_placeholder),
                            if (_mTasksController.assignedTasks.isNotEmpty)
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: _mTasksController.assignedTasks.length,
                                itemBuilder: (_, index) {
                                  final t = _mTasksController.assignedTasks[index];
                                  return TaskCard(
                                    t,
                                    showAssignee: false,
                                    showParent: t.parentId != _project.id,
                                    bottomDivider: index < _mTasksController.assignedTasks.length - 1,
                                  );
                                },
                              ),
                            if (_mTasksController.classifiedTasksCount > 0)
                              SmallText(
                                '${loc.member_tasks_classified_count_prefix} ${loc.task_count_genitive(_mTasksController.classifiedTasksCount)}',
                                padding: const EdgeInsets.symmetric(horizontal: P3).copyWith(top: P),
                              ),
                          ],

                          /// Права в проекте
                          MTListGroupTitle(titleText: loc.role_title),
                          MTListTile(
                            middle: BaseText(_member!.rolesTitles, maxLines: 1),
                            subtitle: SmallText(_member!.rolesDescriptions, maxLines: 1),
                            trailing: _project.canEditMembers ? const EditIcon() : null,
                            bottomDivider: false,
                            loading: _project.loading,
                            onTap: _project.canEditMembers ? () => _editRoles(context) : null,
                          ),
                          MTButton.danger(
                            titleText: loc.member_unlink_action_title,
                            margin: const EdgeInsets.only(top: P6),
                            onTap: () => _unlinkMember(context),
                          ),
                          if (MediaQuery.paddingOf(context).bottom == 0) const SizedBox(height: P3),
                        ],
                      ),
                    )
                  : Container(),
            ),
    );
  }
}
