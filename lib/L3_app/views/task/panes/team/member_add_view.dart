// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/role.dart';
import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/constants.dart';
import '../../../../components/mt_dialog.dart';
import '../../../../components/mt_toolbar.dart';
import '../../../../components/text_widgets.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/role.dart';
import 'invitation_controller.dart';
import 'invitation_pane.dart';
import 'member_add_controller.dart';

Future memberAddDialog(Task task, Role role) async {
  final invitationController = InvitationController(task, role);
  await invitationController.fetchInvitation();
  return await showMTDialog<void>(MemberAddView(invitationController));
}

class MemberAddView extends StatefulWidget {
  const MemberAddView(this.invitationController);
  final InvitationController invitationController;

  @override
  _MemberAddViewState createState() => _MemberAddViewState();
}

class _MemberAddViewState extends State<MemberAddView> {
  InvitationController get _invitationController => widget.invitationController;

  late final InvitationPane _invitationPane;
  // late final WSMembersPane wsMembersPane;

  late final MemberAddController _controller;

  @override
  void initState() {
    _controller = MemberAddController();
    _invitationPane = InvitationPane(_invitationController);
    super.initState();
  }

  @override
  void dispose() {
    _invitationController.dispose();
    super.dispose();
  }

  Widget get tabPaneSelector => Padding(
        padding: const EdgeInsets.symmetric(horizontal: P),
        child: CupertinoSlidingSegmentedControl<MemberSourceKey>(
          children: {
            MemberSourceKey.invitation: NormalText(loc.member_source_invitation_title),
            MemberSourceKey.workspace: NormalText(loc.member_source_workspace_title),
          },
          groupValue: _controller.tabKey,
          onValueChanged: _controller.selectTab,
        ),
      );

  Widget get _selectedPane =>
      {
        // MemberSourceKey.workspace: wsMembersPane,
        MemberSourceKey.invitation: _invitationPane,
      }[_controller.tabKey] ??
      _invitationPane;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTDialog(
        topBar: MTTopBar(titleText: _controller.tabKey == MemberSourceKey.invitation ? '${loc.invitation_share_subject_prefix}${loc.app_title}' : ''),
        body: ListView(
          shrinkWrap: true,
          children: [
            // TODO: https://redmine.moroz.team/issues/2527
            // tabPaneSelector,
            NormalText('${_invitationController.task}:', align: TextAlign.center, maxLines: 3),
            NormalText(_invitationController.role.localize, align: TextAlign.center),
            _selectedPane,
          ],
        ),
      ),
    );
  }
}
