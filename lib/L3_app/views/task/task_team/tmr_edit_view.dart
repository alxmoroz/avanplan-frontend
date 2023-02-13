// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../L1_domain/entities/member.dart';
import '../../../../L1_domain/entities/role.dart';
import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/entities/task_member_role.dart';
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
import '../../../extra/services.dart';
import 'tmr_edit_controller.dart';

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

  late TMREditController controller;

  @override
  void initState() {
    controller = TMREditController();
    // TODO: это всё должно быть в инициализации контроллера!
    // TODO: Сам контроллер инициализировать по образу TaskViewController — передавать айдишник объекта

    controller.initState(tfaList: [
      TFAnnotation('activeDate', label: loc.invitation_active_date_placeholder, noText: true, needValidate: false),
    ]);

    controller.setAllowedRoles([Role(id: null, code: 'ROLE_TEST', wsId: -1)]);
    controller.selectRoleById(tmr?.roleId);

    controller.setActiveDate(DateTime.now().add(const Duration(days: 7)));
    controller.setAllowedMembers([]);
    controller.selectMemberById(tmr?.memberId);

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget textFieldForCode(BuildContext context, String code) {
    final ta = controller.tfAnnoForCode(code);
    final isDate = code.endsWith('Date');

    return ta.noText
        ? MTTextField.noText(
            controller: controller.teControllers[code],
            label: ta.label,
            error: ta.errorText,
            onTap: isDate ? () => controller.selectDate(context) : null,
            prefixIcon: isDate ? const CalendarIcon() : null,
          )
        : MTTextField(
            controller: controller.teControllers[code],
            label: ta.label,
            error: ta.errorText,
          );
  }

  /// общий виджет - форма с полями

  Widget form(BuildContext context) {
    return Scrollbar(
      thumbVisibility: true,
      child: ListView(children: [
        if (controller.allowedRoles.isNotEmpty)
          MTDropdown<Role>(
            onChanged: (r) => controller.selectRole(r),
            value: controller.selectedRole,
            items: controller.allowedRoles,
            margin: tfPadding,
            label: loc.role_title,
          ),
        for (final code in ['activeDate']) textFieldForCode(context, code),
        // TODO: выбор участника из РП или приглашение
        if (controller.allowedMembers.isNotEmpty)
          MTDropdown<Member>(
            onChanged: (m) => controller.selectMember(m),
            value: controller.selectedMember,
            items: controller.allowedMembers,
            margin: tfPadding,
            label: loc.task_assignee_placeholder,
          ),

        const SizedBox(height: P2),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (controller.selectedMember != null) ...[
              // MTButton.outlined(
              //   constrained: false,
              //   titleText: loc.save_action_title,
              //   onTap: controller.validated ? () => controller.save(context, task: task, parent: parent) : null,
              //   padding: const EdgeInsets.symmetric(horizontal: P2),
              // ),
              // if (isNew)
              //   MTButton.outlined(
              //     constrained: false,
              //     titleText: loc.save_and_repeat_action_title,
              //     onTap: controller.validated ? () => controller.save(context, task: task, parent: parent, proceed: true) : null,
              //     margin: const EdgeInsets.only(left: P),
              //     padding: const EdgeInsets.symmetric(horizontal: P),
              //   ),
            ]
          ],
        ),
        const SizedBox(height: P2),
      ]),
    );
  }

  // List<Widget> get statuses => [
  //   if (controller.statuses.isNotEmpty)
  //     MTDropdown<Status>(
  //       onChanged: (status) => controller.selectStatus(status),
  //       value: controller.selectedStatus,
  //       items: controller.statuses,
  //       label: loc.task_status_placeholder,
  //     ),
  //   MTButton(
  //     leading: doneIcon(context, controller.closed),
  //     titleString: loc.state_closed,
  //     margin: tfPadding,
  //     onTap: () => controller.setClosed(!controller.closed),
  //   ),
  // ];

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        navBar: navBar(
          context,
          leading: MTCloseButton(),
          title: loc.member_title,
          trailing: !isNew
              ? MTButton.icon(
                  const DeleteIcon(),
                  // () => controller.delete(context, tmr),
                  null,
                  margin: const EdgeInsets.only(right: P),
                )
              : null,
          bgColor: backgroundColor,
        ),
        body: SafeArea(top: false, bottom: false, child: form(context)),
      ),
    );
  }
}
