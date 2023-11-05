// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/member.dart';
import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/button.dart';
import '../../../../components/checkbox.dart';
import '../../../../components/constants.dart';
import '../../../../components/dialog.dart';
import '../../../../components/text.dart';
import '../../../../components/toolbar.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/task_type.dart';
import 'member_edit_controller.dart';

Future<Iterable<Member>?> memberEditDialog(Task task, Member member) async => await showMTDialog<Iterable<Member>?>(MemberEditDialog(task, member));

class MemberEditDialog extends StatefulWidget {
  const MemberEditDialog(this.task, this.member);
  final Task task;
  final Member member;

  @override
  _MemberEditDialogState createState() => _MemberEditDialogState();
}

class _MemberEditDialogState extends State<MemberEditDialog> {
  Task get task => widget.task;
  Member get member => widget.member;

  late final MemberEditController controller;

  @override
  void initState() {
    controller = MemberEditController(task, member);
    super.initState();
  }

  Widget _roleItem(BuildContext context, int index) {
    final role = controller.roles[index];
    final value = role.selected;
    return MTCheckBoxTile(
      title: role.title,
      description: role.description,
      value: value,
      bottomDivider: index < controller.roles.length - 1,
      onChanged: (bool? value) => controller.selectRole(role, value),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTDialog(
        topBar: MTTopBar(
          middle: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BaseText.medium('$member', maxLines: 1),
              const SizedBox(height: P),
              task.subPageTitle(loc.role_list_title),
              const SizedBox(height: P),
            ],
          ),
        ),
        topBarHeight: P * 14,
        body: ListView(
          shrinkWrap: true,
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: _roleItem,
              itemCount: controller.roles.length,
            ),
            MTButton.main(
              titleText: loc.save_action_title,
              margin: const EdgeInsets.only(top: P3),
              onTap: controller.assignRoles,
            )
          ],
        ),
      ),
    );
  }
}
