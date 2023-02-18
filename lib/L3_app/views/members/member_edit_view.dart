// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/member.dart';
import '../../../L1_domain/entities/task.dart';
import '../../../main.dart';
import '../../components/colors.dart';
import '../../components/mt_bottom_sheet.dart';
import '../../components/mt_close_button.dart';
import '../../components/mt_page.dart';
import '../../components/navbar.dart';
import '../../components/text_widgets.dart';

Future<Member?> memberEditDialog(Task task, Member member) async {
  return await showModalBottomSheet<Member?>(
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

  // late final MemberEditController controller;

  @override
  void initState() {
    // controller = MemberEditController();
    super.initState();
  }

  @override
  void dispose() {
    // controller.dispose();
    super.dispose();
  }

  Widget form(BuildContext context) {
    return Scrollbar(
      thumbVisibility: true,
      child: ListView(children: [
        for (final r in member.roles) NormalText(r),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        navBar: navBar(
          context,
          leading: MTCloseButton(),
          title: 'РОЛИ $member',
          bgColor: backgroundColor,
        ),
        body: SafeArea(top: false, bottom: false, child: form(context)),
      ),
    );
  }
}
