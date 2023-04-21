// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/estimate_value.dart';
import '../../../L1_domain/entities/member.dart';
import '../../../L1_domain/entities/task.dart';
import '../../../main.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_bottom_sheet.dart';
import '../../components/mt_button.dart';
import '../../components/mt_close_button.dart';
import '../../components/mt_dropdown.dart';
import '../../components/mt_page.dart';
import '../../components/mt_text_field.dart';
import '../../components/navbar.dart';
import '../../extra/services.dart';
import '../../presenters/task_level_presenter.dart';
import 'task_edit_controller.dart';

class EditTaskResult {
  const EditTaskResult(this.task, [this.proceed]);
  final Task task;
  final bool? proceed;
}

Future<EditTaskResult?> editTaskDialog(int wsId, {required Task parent, Task? task}) async {
  return await showModalBottomSheet<EditTaskResult?>(
    context: rootKey.currentContext!,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => MTBottomSheet(TaskEditView(wsId, parent: parent, task: task)),
  );
}

class TaskEditView extends StatefulWidget {
  const TaskEditView(this.wsId, {required this.parent, this.task});

  final int wsId;
  final Task parent;
  final Task? task;

  @override
  _TaskEditViewState createState() => _TaskEditViewState();
}

class _TaskEditViewState extends State<TaskEditView> {
  late final TaskEditController controller;

  @override
  void initState() {
    controller = TaskEditController(widget.wsId, widget.parent, widget.task);
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
            onTap: isDate ? () => controller.selectDate(code) : null,
            prefixIcon: isDate ? const CalendarIcon() : null,
            suffixIcon: isDate && ta.text.isNotEmpty
                ? MTButton(
                    middle: Row(
                      children: [
                        Container(height: P * 3, width: 1, color: borderColor.resolve(context)),
                        const SizedBox(width: P),
                        const CloseIcon(color: dangerColor),
                        const SizedBox(width: P),
                      ],
                    ),
                    onTap: () => controller.resetDate(code),
                  )
                : null,
          )
        : MTTextField(
            controller: controller.teControllers[code],
            label: ta.label,
            error: ta.errorText,
          );
  }

  /// общий виджет - форма с полями для задач и целей

  Widget form(BuildContext context) {
    return Scrollbar(
      thumbVisibility: true,
      child: ListView(children: [
        for (final code in ['title', 'startDate', 'dueDate', 'description']) textFieldForCode(context, code),
        // ...[statuses],
        if (controller.allowedAssignees.isNotEmpty)
          MTDropdown<Member>(
            onChanged: (m) => controller.selectAssignee(m),
            value: controller.selectedAssignee,
            items: controller.allowedAssignees,
            margin: tfPadding,
            label: loc.task_assignee_placeholder,
          ),
        if (controller.canEstimate)
          MTDropdown<EstimateValue>(
            onChanged: (est) => controller.selectEstimate(est),
            value: controller.selectedEstimate,
            items: controller.estimateValues.toList(),
            margin: tfPadding,
            label: loc.task_estimate_placeholder,
            helper: controller.estimateHelper,
          ),
        const SizedBox(height: P2),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MTButton.outlined(
              constrained: false,
              titleText: loc.save_action_title,
              onTap: controller.validated ? controller.save : null,
              padding: const EdgeInsets.symmetric(horizontal: P2),
            ),
            if (controller.isNew)
              MTButton.outlined(
                constrained: false,
                titleText: controller.saveAndGoBtnTitle,
                onTap: controller.validated ? () => controller.save(proceed: true) : null,
                margin: const EdgeInsets.only(left: P),
                padding: const EdgeInsets.symmetric(horizontal: P),
              ),
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
          title: controller.isNew ? controller.parent.newSubtaskTitle : '',
          trailing: !controller.isNew
              ? MTButton.icon(
                  const DeleteIcon(),
                  controller.delete,
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
