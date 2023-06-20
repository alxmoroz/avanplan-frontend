// Copyright (c) 2023. Alexandr Moroz

import 'package:avanplan/L3_app/components/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/member.dart';
import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/constants.dart';
import '../../../../components/mt_button.dart';
import '../../../../components/mt_checkbox.dart';
import '../../../../components/mt_dialog.dart';
import '../../../../components/mt_toolbar.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/role_presenter.dart';
import '../../../../presenters/task_level_presenter.dart';
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
              MediumText('$member'),
              task.subPageTitle(loc.role_list_title),
              const SizedBox(height: P_2),
            ],
          ),
        ),
        topBarHeight: P * 7.5,
        body: ListView.builder(
          shrinkWrap: true,
          itemBuilder: _roleItem,
          itemCount: controller.roles.length,
        ),
        bottomBar: MTButton.main(
          titleText: loc.save_action_title,
          onTap: controller.assignRoles,
        ),
      ),
    );
  }
}
