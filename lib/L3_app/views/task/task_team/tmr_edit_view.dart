// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/entities/task_member_role.dart';
import '../../../../main.dart';
import '../../../components/colors.dart';
import '../../../components/constants.dart';
import '../../../components/icons.dart';
import '../../../components/mt_bottom_sheet.dart';
import '../../../components/mt_button.dart';
import '../../../components/mt_close_button.dart';
import '../../../components/mt_page.dart';
import '../../../components/navbar.dart';
import '../../../components/text_widgets.dart';
import '../../../extra/services.dart';
import '../../../presenters/role_presenter.dart';
import 'invitation_pane.dart';
import 'tmr_controller.dart';
import 'ws_members_pane.dart';

class EditTMRResult {
  const EditTMRResult(this.tmr, [this.proceed]);
  final TaskMemberRole tmr;
  final bool? proceed;
}

Future<EditTMRResult?> editTMRDialog(TMRController controller) async {
  return await showModalBottomSheet<EditTMRResult?>(
    context: rootKey.currentContext!,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => MTBottomSheet(TMREditView(controller)),
  );
}

class TMREditView extends StatefulWidget {
  const TMREditView(this.controller, {this.tmr});
  final TMRController controller;
  final TaskMemberRole? tmr;

  @override
  _TMREditViewState createState() => _TMREditViewState();
}

class _TMREditViewState extends State<TMREditView> {
  TMRController get controller => widget.controller;
  Task get task => controller.task;
  TaskMemberRole? get tmr => widget.tmr;
  bool get isNew => tmr == null;

  late final InvitationPane invitationPane;
  late final WSMembersPane wsMembersPane;

  @override
  void initState() {
    if (tmr != null) {
      controller.selectRoleById(tmr?.roleId);
      controller.selectMemberById(tmr?.memberId);
    }

    invitationPane = InvitationPane(controller);
    wsMembersPane = WSMembersPane(controller);

    super.initState();
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
        MemberSourceKey.workspace: wsMembersPane,
        MemberSourceKey.invitation: invitationPane,
      }[controller.tabKey] ??
      invitationPane;

  /// общий виджет - форма с полями

  Widget form(BuildContext context) {
    return Scrollbar(
      thumbVisibility: true,
      child: ListView(children: [
        // TODO: https://redmine.moroz.team/issues/2520
        // tabPaneSelector,
        H4(controller.role!.localize, align: TextAlign.center),
        selectedPane,
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
          title: controller.tabKey == MemberSourceKey.invitation ? controller.invitationSubject : '',
          trailing: !isNew && controller.tabKey == MemberSourceKey.workspace
              ? const MTButton.icon(
                  DeleteIcon(),
                  null,
                  // () => controller.delete(context, tmr),
                  margin: EdgeInsets.only(right: P),
                )
              : null,
          bgColor: backgroundColor,
        ),
        body: SafeArea(top: false, bottom: false, child: form(context)),
      ),
    );
  }
}
