// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/estimate_value.dart';
import '../../../L1_domain/entities/member.dart';
import '../../../L1_domain/entities/task.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_button.dart';
import '../../components/mt_close_button.dart';
import '../../components/mt_dialog.dart';
import '../../components/mt_dropdown.dart';
import '../../components/mt_text_field.dart';
import '../../components/navbar.dart';
import '../../extra/services.dart';
import '../../presenters/task_level_presenter.dart';
import '../../presenters/ws_presenter.dart';
import 'task_edit_controller.dart';

class EditTaskResult {
  const EditTaskResult(this.task, [this.proceed]);
  final Task task;
  final bool? proceed;
}

Future<EditTaskResult?> editTaskDialog(TaskEditController controller) async => await showMTDialog<EditTaskResult?>(TaskEditView(controller));

class TaskEditView extends StatefulWidget {
  const TaskEditView(this.controller);

  final TaskEditController controller;

  @override
  _TaskEditViewState createState() => _TaskEditViewState();
}

class _TaskEditViewState extends State<TaskEditView> {
  TaskEditController get controller => widget.controller;

  Widget textFieldForCode(BuildContext context, String code) {
    final ta = controller.tfa(code);

    return ta.noText
        ? MTTextField.noText(
            controller: controller.teControllers[code],
            label: ta.label,
            error: ta.errorText,
          )
        : MTTextField(
            controller: controller.teControllers[code],
            label: ta.label,
            error: ta.errorText,
          );
  }

  /// общий виджет - форма с полями для задач и целей

  Widget form(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        for (final code in ['title', 'description']) textFieldForCode(context, code),
        if (controller.allowedAssignees.isNotEmpty)
          MTDropdown<Member>(
            onChanged: controller.selectAssigneeId,
            value: controller.selectedAssigneeId,
            items: controller.allowedAssignees,
            margin: tfPadding,
            label: loc.task_assignee_placeholder,
          ),
        if (controller.canEstimate)
          MTDropdown<EstimateValue>(
            onChanged: controller.selectEstimateId,
            value: controller.selectedEstimateId,
            items: controller.estimateValues,
            margin: tfPadding,
            label: loc.task_estimate_placeholder,
            helper: controller.estimateHelper,
          ),
        const SizedBox(height: P2),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MTButton(
              constrained: !controller.isNew,
              titleText: loc.save_action_title,
              onTap: controller.validated ? controller.save : null,
              padding: const EdgeInsets.symmetric(horizontal: P2),
              type: controller.isNew ? ButtonType.secondary : ButtonType.main,
            ),
            if (controller.isNew)
              MTButton.main(
                constrained: false,
                titleText: controller.saveAndGoBtnTitle,
                onTap: controller.validated ? () => controller.save(proceed: true) : null,
                margin: const EdgeInsets.only(left: P),
                padding: const EdgeInsets.symmetric(horizontal: P2),
              ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTDialog(
        topBar: navBar(
          context,
          leading: MTCloseButton(),
          middle: controller.isNew ? controller.ws.subPageTitle(controller.parent.newSubtaskTitle) : null,
          trailing: !controller.isNew
              ? MTButton.icon(
                  const DeleteIcon(),
                  controller.delete,
                  margin: const EdgeInsets.only(right: P),
                )
              : null,
          bgColor: backgroundColor,
        ),
        body: SafeArea(
          bottom: false,
          child: form(context),
        ),
      ),
    );
  }
}
