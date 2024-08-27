// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

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

Future memberRolesDialog(MemberRolesController controller) async => await showMTDialog<void>(_MemberRolesDialog(controller));

class _MemberRolesDialog extends StatelessWidget {
  const _MemberRolesDialog(this._controller);
  final MemberRolesController _controller;

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
              _controller.task.subPageTitle(loc.role_list_title),
              BaseText.f2('${_controller.member}', maxLines: 1),
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
            const SizedBox(height: P3),
            MTButton.main(
              titleText: loc.save_action_title,
              onTap: () => _controller.assignRoles(context),
            ),
            if (MediaQuery.paddingOf(context).bottom == 0) const SizedBox(height: P3),
          ],
        ),
      ),
    );
  }
}
