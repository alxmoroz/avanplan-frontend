// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/member.dart';
import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities_extensions/task_members.dart';
import '../../../../components/avatar.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/dialog.dart';
import '../../../../components/icons.dart';
import '../../../../components/list_tile.dart';
import '../../../../components/refresh.dart';
import '../../../../components/text.dart';
import '../../../../components/toolbar.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/person.dart';
import '../../../../presenters/task_type.dart';
import '../../../../presenters/ws_member.dart';
import '../../../../usecases/task_actions.dart';
import '../../../_base/loader_screen.dart';
import '../../controllers/task_controller.dart';
import '../tasks/task_card.dart';
import 'member_roles_controller.dart';
import 'member_roles_dialog.dart';
import 'member_tasks_controller.dart';

Future taskMemberDialog(TaskController taskController, int memberId) async {
  return await showMTDialog<void>(_MemberDialog(taskController, memberId, MemberTasksController(taskController.task.wsId, memberId)));
}

class _MemberDialog extends StatelessWidget {
  const _MemberDialog(this._taskController, this._memberId, this._mTasksController);
  final TaskController _taskController;
  final MemberTasksController _mTasksController;
  final int _memberId;

  Task get _project => _taskController.task;
  WSMember? get _member => _project.memberForId(_memberId);

  Future _editRoles(BuildContext context) async {
    await memberRolesDialog(MemberRolesController(_project, _memberId));
    if (_member == null && context.mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => _mTasksController.loading
          ? LoaderScreen(_mTasksController, isDialog: true)
          : MTDialog(
              topBar: MTAppBar(showCloseButton: true, color: b2Color, middle: _project.subPageTitle(loc.member_title)),
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
                          if (_member!.roles.isNotEmpty) ...[
                            MTListGroupTitle(titleText: loc.role_list_title),
                            MTListTile(
                              middle: BaseText(_member!.rolesStr),
                              trailing: _project.canEditMembers ? const EditIcon() : null,
                              bottomDivider: false,
                              loading: _project.loading,
                              onTap: _project.canEditMembers ? () => _editRoles(context) : null,
                            )
                          ] else if (MediaQuery.paddingOf(context).bottom == 0)
                            const SizedBox(height: P3),
                        ],
                      ),
                    )
                  : Container(),
            ),
    );
  }
}
