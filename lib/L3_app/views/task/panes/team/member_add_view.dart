// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/role.dart';
import '../../../../../L1_domain/entities/task.dart';
import '../../../../../main.dart';
import '../../../../components/colors.dart';
import '../../../../components/constants.dart';
import '../../../../components/mt_bottom_sheet.dart';
import '../../../../components/mt_close_button.dart';
import '../../../../components/mt_page.dart';
import '../../../../components/navbar.dart';
import '../../../../components/text_widgets.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/role_presenter.dart';
import 'invitation_controller.dart';
import 'invitation_pane.dart';
import 'member_add_controller.dart';

Future memberAddDialog(Task task, Role role) async {
  final invitationController = InvitationController(task, role);
  await invitationController.fetchInvitation();
  return await showModalBottomSheet<void>(
    context: rootKey.currentContext!,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => MTBottomSheet(MemberAddView(invitationController)),
  );
}

class MemberAddView extends StatefulWidget {
  const MemberAddView(this.invitationController);
  final InvitationController invitationController;

  @override
  _MemberAddViewState createState() => _MemberAddViewState();
}

class _MemberAddViewState extends State<MemberAddView> {
  InvitationController get invitationController => widget.invitationController;

  late final InvitationPane invitationPane;
  // late final WSMembersPane wsMembersPane;

  late final MemberAddController controller;

  @override
  void initState() {
    controller = MemberAddController();
    invitationPane = InvitationPane(invitationController);
    super.initState();
  }

  @override
  void dispose() {
    invitationController.dispose();
    super.dispose();
  }

  Widget get tabPaneSelector => Padding(
        padding: const EdgeInsets.symmetric(horizontal: P),
        child: CupertinoSlidingSegmentedControl<MemberSourceKey>(
          children: {
            MemberSourceKey.invitation: NormalText(loc.member_source_invitation_title),
            MemberSourceKey.workspace: NormalText(loc.member_source_workspace_title),
          },
          groupValue: controller.tabKey,
          onValueChanged: controller.selectTab,
        ),
      );

  Widget get selectedPane =>
      {
        // MemberSourceKey.workspace: wsMembersPane,
        MemberSourceKey.invitation: invitationPane,
      }[controller.tabKey] ??
      invitationPane;

  /// общий виджет - форма с полями

  Widget get form => ListView(
        children: [
          // TODO: https://redmine.moroz.team/issues/2527
          // tabPaneSelector,
          H4(invitationController.role.localize, align: TextAlign.center),
          selectedPane,
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        navBar: navBar(
          context,
          leading: MTCloseButton(),
          title: controller.tabKey == MemberSourceKey.invitation ? invitationController.invitationSubject : '',
          bgColor: backgroundColor,
        ),
        body: SafeArea(top: false, bottom: false, child: form),
      ),
    );
  }
}
