// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';

import '../../../../L1_domain/entities/role.dart';
import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/entities/task_member_role.dart';
import '../../../../L1_domain/usecases/task_ext_level.dart';
import '../../../../main.dart';
import '../../../components/colors.dart';
import '../../../components/constants.dart';
import '../../../components/icons.dart';
import '../../../components/mt_bottom_sheet.dart';
import '../../../components/mt_button.dart';
import '../../../components/mt_close_button.dart';
import '../../../components/mt_dropdown.dart';
import '../../../components/mt_page.dart';
import '../../../components/mt_text_field.dart';
import '../../../components/navbar.dart';
import '../../../components/text_field_annotation.dart';
import '../../../components/text_widgets.dart';
import '../../../extra/services.dart';
import '../../../presenters/role_presenter.dart';
import 'invitation_pane.dart';
import 'tmr_edit_controller.dart';
import 'ws_members_pane.dart';

class EditTMRResult {
  const EditTMRResult(this.tmr, [this.proceed]);
  final TaskMemberRole tmr;
  final bool? proceed;
}

Future<EditTMRResult?> editTMRDialog({required Task task}) async {
  return await showModalBottomSheet<EditTMRResult?>(
    context: rootKey.currentContext!,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => MTBottomSheet(TMREditView(task: task)),
  );
}

class TMREditView extends StatefulWidget {
  const TMREditView({required this.task, this.tmr});

  final Task task;
  final TaskMemberRole? tmr;

  @override
  _TMREditViewState createState() => _TMREditViewState();
}

class _TMREditViewState extends State<TMREditView> {
  Task get task => widget.task;
  TaskMemberRole? get tmr => widget.tmr;
  bool get isNew => tmr == null;

  late final TMREditController controller;
  late final InvitationPane invitationPane;
  late final WSMembersPane wsMembersPane;

  @override
  void initState() {
    controller = TMREditController(task);
    // TODO: это всё должно быть в инициализации контроллера!
    // TODO: Сам контроллер инициализировать по образу TaskViewController — передавать айдишник объекта

    controller.initState(tfaList: [
      TFAnnotation('activeDate', label: loc.invitation_active_until_placeholder, noText: true),
      TFAnnotation('activationsCount', label: loc.invitation_activations_count_placeholder, text: '10'),
    ]);

    controller.setAllowedRoles(task.projectWs?.roles ?? []);
    controller.selectRoleById(tmr?.roleId);

    controller.setActiveDate(DateTime.now().add(const Duration(days: 7)));
    controller.setAllowedMembers([]);
    controller.selectMemberById(tmr?.memberId);

    invitationPane = InvitationPane(controller);
    wsMembersPane = WSMembersPane(controller);

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
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
        MemberSourceKey.workspace: wsMembersPane,
        MemberSourceKey.invitation: invitationPane,
      }[controller.tabKey] ??
      invitationPane;

  /// общий виджет - форма с полями

  Widget form(BuildContext context) {
    return Scrollbar(
      thumbVisibility: true,
      child: ListView(children: [
        if (controller.allowedRoles.isNotEmpty)
          MTDropdown<Role>(
            onChanged: (r) => controller.selectRole(r),
            value: controller.role,
            ddItems: [
              for (final r in controller.allowedRoles)
                DropdownMenuItem<Role>(value: r, child: NormalText(Intl.message('role_code_${r.code.toLowerCase()}')))
            ],
            margin: tfPadding,
            label: loc.role_title,
          ),
        const SizedBox(height: P),
        tabPaneSelector,
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
          title: controller.role?.localize ?? '',
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
