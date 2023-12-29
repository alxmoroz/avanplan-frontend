// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/member.dart';
import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities_extensions/task_members.dart';
import '../../../../components/button.dart';
import '../../../../components/checkbox.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/dialog.dart';
import '../../../../components/text.dart';
import '../../../../components/toolbar.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/task_type.dart';
import 'member_roles_controller.dart';

Future showMemberRolesDialog(MemberRolesController controller) async => await showMTDialog<void>(MemberRolesDialog(controller));

class MemberRolesDialog extends StatelessWidget {
  const MemberRolesDialog(this._controller);
  final MemberRolesController _controller;

  Task get _task => _controller.task;
  Member? get _member => _task.memberForId(_controller.memberId);

  Widget _roleItem(BuildContext context, int index) {
    final role = _controller.roles[index];
    final value = role.selected;
    return MTCheckBoxTile(
      title: role.title,
      description: role.description,
      value: value,
      bottomDivider: index < _controller.roles.length - 1,
      onChanged: (bool? value) => _controller.selectRole(role, value),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTDialog(
        topBar: MTAppBar(
          showCloseButton: true,
          color: b2Color,
          innerHeight: P12,
          middle: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _task.subPageTitle(loc.role_list_title),
              BaseText.f2('$_member', maxLines: 1),
            ],
          ),
        ),
        body: ListView(
          shrinkWrap: true,
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: _roleItem,
              itemCount: _controller.roles.length,
            ),
            MTButton.main(
              titleText: loc.save_action_title,
              margin: const EdgeInsets.only(top: P3),
              onTap: _controller.assignRoles,
            )
          ],
        ),
      ),
    );
  }
}
