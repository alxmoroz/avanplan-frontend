// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/member.dart';
import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/button.dart';
import '../../../../components/checkbox.dart';
import '../../../../components/constants.dart';
import '../../../../components/dialog.dart';
import '../../../../components/shadowed.dart';
import '../../../../components/text.dart';
import '../../../../components/toolbar.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/role.dart';
import '../../../../presenters/task_type.dart';
import 'member_edit_controller.dart';

Future<Iterable<Member>?> memberEditDialog(Task task, Member member) async => await showMTDialog<Iterable<Member>?>(MemberEditView(task, member));

class MemberEditView extends StatefulWidget {
  const MemberEditView(this.task, this.member);
  final Task task;
  final Member member;

  @override
  _MemberEditViewState createState() => _MemberEditViewState();
}

class _MemberEditViewState extends State<MemberEditView> {
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
      title: role.localize,
      value: value,
      bottomBorder: index < controller.roles.length - 1,
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
              BaseText.medium('$member'),
              task.subPageTitle(loc.role_list_title),
            ],
          ),
        ),
        topBarHeight: P * 14,
        body: MTShadowed(
          bottomShadow: true,
          child: ListView.builder(
            shrinkWrap: true,
            itemBuilder: _roleItem,
            itemCount: controller.roles.length,
          ),
        ),
        bottomBar: MTButton.main(
          titleText: loc.save_action_title,
          onTap: controller.assignRoles,
        ),
      ),
    );
  }
}
