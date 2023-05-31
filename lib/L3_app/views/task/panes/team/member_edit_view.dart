// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/member.dart';
import '../../../../../L1_domain/entities/task.dart';
import '../../../../../main.dart';
import '../../../../components/colors.dart';
import '../../../../components/constants.dart';
import '../../../../components/mt_bottom_sheet.dart';
import '../../../../components/mt_button.dart';
import '../../../../components/mt_checkbox.dart';
import '../../../../components/mt_close_button.dart';
import '../../../../components/mt_page.dart';
import '../../../../components/mt_text_field.dart';
import '../../../../components/navbar.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/role_presenter.dart';
import '../../../../presenters/task_level_presenter.dart';
import 'member_edit_controller.dart';

Future<Iterable<Member>?> memberEditDialog(Task task, Member member) async {
  return await showModalBottomSheet<Iterable<Member>?>(
    context: rootKey.currentContext!,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => MTBottomSheet(MemberEditView(task, member)),
  );
}

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

  Widget get form => Column(
        children: [
          task.subPageTitle(loc.role_list_title),
          const SizedBox(height: P_2),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: _roleItem,
              itemCount: controller.roles.length,
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        navBar: navBar(
          context,
          leading: MTCloseButton(),
          title: '$member',
          bgColor: backgroundColor,
        ),
        body: SafeArea(bottom: false, child: form),
        bottomBar: MTButton.main(
          titleText: loc.save_action_title,
          margin: tfPadding.copyWith(top: P2),
          onTap: controller.assignRoles,
        ),
      ),
    );
  }
}
