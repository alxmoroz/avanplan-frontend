// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/estimate_value.dart';
import '../../../L1_domain/entities/member.dart';
import '../../../L1_domain/entities/task.dart';
import '../../../L1_domain/usecases/task_ext_level.dart';
import '../../../L1_domain/usecases/task_ext_state.dart';
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
import '../../components/text_field_annotation.dart';
import '../../extra/services.dart';
import '../../presenters/task_level_presenter.dart';
import 'task_edit_controller.dart';

//TODO: подумать над унификацией полей. Возможно, получится избавиться от дуэта MTField и TFAnnotation

class EditTaskResult {
  const EditTaskResult(this.task, [this.proceed]);
  final Task task;
  final bool? proceed;
}

Future<EditTaskResult?> editTaskDialog({required Task parent, Task? task}) async {
  return await showModalBottomSheet<EditTaskResult?>(
    context: rootKey.currentContext!,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => MTBottomSheet(TaskEditView(task: task, parent: parent)),
  );
}

class TaskEditView extends StatefulWidget {
  const TaskEditView({required this.parent, this.task});

  final Task parent;
  final Task? task;

  @override
  _TaskEditViewState createState() => _TaskEditViewState();
}

class _TaskEditViewState extends State<TaskEditView> {
  Task? get task => widget.task;
  Task get parent => widget.parent;
  bool get isNew => task == null;

  int? get _savedWsID => task?.wsId ?? parent.wsId;

  late TaskEditController controller;

  @override
  void initState() {
    controller = TaskEditController();
    // TODO: это всё должно быть в инициализации контроллера!
    // TODO: Сам контроллер инициализировать по образу TaskViewController — передавать айдишник задачи

    controller.initState(tfaList: [
      TFAnnotation('title', label: loc.title, text: task?.title ?? ''),
      TFAnnotation('description', label: loc.description, text: task?.description ?? '', needValidate: false),
      TFAnnotation('startDate', label: loc.task_start_date_placeholder, noText: true, needValidate: false),
      TFAnnotation('dueDate', label: loc.task_due_date_placeholder, noText: true, needValidate: false),
    ]);

    controller.setStartDate(task?.startDate);
    controller.setDueDate(task?.dueDate);
    controller.selectWS(_savedWsID);
    controller.selectEstimateByValue(task?.estimate);
    controller.setAllowedAssignees([
      Member(fullName: loc.task_assignee_nobody, wsId: -1, id: null, email: '', userId: null),
      ...task?.project?.members ?? [],
    ]);
    controller.selectAssigneeById(task?.assignee?.id);

    // controller.selectStatus(task?.status);
    // controller.selectType(task?.type);
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
            onTap: isDate ? () => controller.selectDate(context, code) : null,
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
        // TODO: перенос между РП??
        if (_savedWsID == null) controller.wsDropdown(context),
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
        if (controller.estimateValues.isNotEmpty && (isNew || task?.hasSubtasks == false))
          MTDropdown<EstimateValue>(
            onChanged: (est) => controller.selectEstimate(est),
            value: controller.selectedEstimate,
            items: controller.estimateValues,
            margin: tfPadding,
            label: loc.task_estimate_placeholder,
            helper: controller.selectedEstimate == null && task?.estimate != null ? '${loc.task_estimate_placeholder}: ${task?.estimate}' : null,
          ),
        const SizedBox(height: P2),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MTButton.outlined(
              constrained: false,
              titleText: loc.save_action_title,
              onTap: controller.validated ? () => controller.save(context, task: task, parent: parent) : null,
              padding: const EdgeInsets.symmetric(horizontal: P2),
            ),
            if (isNew)
              MTButton.outlined(
                constrained: false,
                titleText: (parent.isProject || parent.isWorkspace) ? loc.save_and_go_action_title : loc.save_and_repeat_action_title,
                onTap: controller.validated ? () => controller.save(context, task: task, parent: parent, proceed: true) : null,
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
          title: isNew ? parent.newSubtaskTitle : '',
          trailing: !isNew
              ? MTButton.icon(
                  const DeleteIcon(),
                  () => controller.delete(context, task!),
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
