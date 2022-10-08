// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/status.dart';
import '../../../L1_domain/entities/task.dart';
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

Future<Task?> editTaskDialog(BuildContext context, {required Task parent, Task? task}) async {
  return await showModalBottomSheet<Task?>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => MTBottomSheet(TaskEditView(task: task, parent: parent), context),
  );
}

class TaskEditView extends StatefulWidget {
  const TaskEditView({required this.parent, this.task});
  static String get routeName => 'task_edit';

  final Task parent;
  final Task? task;

  @override
  _TaskEditViewState createState() => _TaskEditViewState();
}

class _TaskEditViewState extends State<TaskEditView> {
  Task? get task => widget.task;
  Task get parent => widget.parent;
  bool get isNew => task == null;

  late TaskEditController controller;

  //TODO: валидация о заполненности работает неправильно, не сбрасывается после закрытия диалога
  // возможно, остаются tfa с теми же кодами для новых вьюх этого же контроллера и у них висит признак о произошедшем редактировании поля
  // была попытка использовать TFAnnotation для выбора статуса, чтобы реагировать на изменения поля в плане логики валидации
  @override
  void initState() {
    controller = TaskEditController();
    //TODO: возможно, это должно быть в инициализации контроллера?

    controller.initState(tfaList: [
      TFAnnotation('title', label: loc.title, text: task?.title ?? ''),
      TFAnnotation('description', label: loc.description, text: task?.description ?? '', needValidate: false),
      TFAnnotation('dueDate', label: loc.task_due_date_placeholder, noText: true, needValidate: false),
    ]);

    controller.setDueDate(task?.dueDate);
    controller.setClosed(task?.closed);
    controller.selectWS(task?.workspaceId ?? parent.workspaceId);
    controller.selectStatus(task?.status);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget textFieldForCode(BuildContext context, String code, {VoidCallback? onTap}) {
    final ta = controller.tfAnnoForCode(code);
    final isDate = code.endsWith('Date');
    final isDueDate = code == 'dueDate';
    return ta.noText
        ? MTTextField.noText(
            controller: controller.teControllers[code],
            label: ta.label,
            error: ta.errorText,
            onTap: onTap ?? (isDueDate ? () => controller.inputDueDate(context) : null),
            prefixIcon: isDate ? calendarIcon(context) : null,
            suffixIcon: isDueDate && controller.selectedDueDate != null
                ? MTButton(
                    middle: Row(
                      children: [
                        Container(height: onePadding * 3, width: 1, color: borderColor.resolve(context)),
                        SizedBox(width: onePadding),
                        closeIcon(context, color: dangerColor),
                        SizedBox(width: onePadding),
                      ],
                    ),
                    onTap: isDueDate ? () => controller.setDueDate(null) : null,
                  )
                : null,
          )
        : MTTextField(
            controller: controller.teControllers[code],
            label: ta.label,
            error: ta.errorText,
            onTap: onTap,
          );
  }

  /// общий виджет - форма с полями для задач и целей

  Widget form(BuildContext context) {
    return Scrollbar(
      thumbVisibility: true,
      child: ListView(children: [
        if (controller.selectedWS == null) controller.wsDropdown(context),
        ...['title', 'dueDate', 'description'].map((code) => textFieldForCode(context, code)),
        if (controller.statuses.isNotEmpty)
          MTDropdown<Status>(
            onChanged: (status) => controller.selectStatus(status),
            value: controller.selectedStatus,
            items: controller.statuses,
            label: loc.task_status_placeholder,
          ),
        MTButton(
          leading: doneIcon(context, controller.closed),
          titleString: loc.task_state_closed,
          margin: tfPadding,
          onTap: () => controller.setClosed(!controller.closed),
        ),
        if (!isNew)
          MTButton.outlined(
            titleString: loc.delete_action_title,
            titleColor: dangerColor,
            margin: tfPadding.copyWith(top: onePadding * 4),
            onTap: () => controller.delete(context, task!),
          ),
        SizedBox(height: onePadding),
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
          title: isNew ? parent.newSubtaskTitle : '',
          trailing: MTButton(
            titleString: loc.save_action_title,
            onTap: controller.validated ? () => controller.save(context, task: task, parent: parent) : null,
            margin: EdgeInsets.only(right: onePadding),
          ),
        ),
        body: SafeArea(
          top: false,
          bottom: false,
          child: form(context),
        ),
      ),
    );
  }
}
