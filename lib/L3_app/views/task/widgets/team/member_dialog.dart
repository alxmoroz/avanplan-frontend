// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/member.dart';
import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities_extensions/task_members.dart';
import '../../../../components/constants.dart';
import '../../../../components/dialog.dart';
import '../../../../components/icons.dart';
import '../../../../components/list_tile.dart';
import '../../../../components/text.dart';
import '../../../../components/toolbar.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/person.dart';
import '../../../../presenters/task_type.dart';
import '../../../../usecases/task_actions.dart';
import '../../controllers/task_controller.dart';
import 'member_roles_controller.dart';
import 'member_roles_dialog.dart';

Future showMemberDialog(TaskController controller, int memberId) async => await showMTDialog<void>(MemberDialog(controller, memberId));

class MemberDialog extends StatelessWidget {
  const MemberDialog(this._controller, this._memberId);
  final TaskController _controller;
  final int _memberId;

  Task get _task => _controller.task!;
  Member? get _member => _task.memberForId(_memberId);

  Future editRoles(BuildContext context) async {
    await showMemberRolesDialog(MemberRolesController(_task, _memberId));
    if (_member == null) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTDialog(
        topBar: MTToolBar(middle: _task.subPageTitle(loc.member_title)),
        body: _member != null
            ? ListView(
                shrinkWrap: true,
                children: [
                  const SizedBox(height: P3),
                  _member!.icon(P10),
                  const SizedBox(height: P3),
                  H3('$_member', align: TextAlign.center),
                  BaseText(_member!.email, align: TextAlign.center),
                  if (_member!.roles.isNotEmpty) ...[
                    MTListSection(titleText: loc.role_list_title),
                    MTListTile(
                      middle: BaseText(_member!.rolesStr),
                      trailing: _task.canEditMembers ? const EditIcon() : null,
                      bottomDivider: false,
                      loading: _task.loading,
                      onTap: () => _task.canEditMembers ? editRoles(context) : null,
                    )
                  ]
                ],
              )
            : Container(),
      ),
    );
  }
}
